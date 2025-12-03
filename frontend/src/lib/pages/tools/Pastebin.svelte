<script lang="ts">
  import { _ } from 'svelte-i18n';
  import { api } from '../../api';
  import { Link } from 'svelte-routing';
  import { compressImage, formatFileSize } from '../../imageCompressor';
  
  // Form state
  let content = '';
  let title = '';
  let language = 'text';
  let password = '';
  let expiresInHours = 24;
  let burnAfterRead = false;
  let maxViews: number | null = null;
  let images: string[] = [];
  
  // UI state
  let isSubmitting = false;
  let createdPaste: { paste_id: string; expires_at: string } | null = null;
  let error = '';
  let copied = false;
  let isCompressing = false;
  let compressionInfo = '';
  
  const languages = [
    { value: 'text', label: 'Texte brut' },
    { value: 'javascript', label: 'JavaScript' },
    { value: 'python', label: 'Python' },
    { value: 'html', label: 'HTML' },
    { value: 'css', label: 'CSS' },
    { value: 'json', label: 'JSON' },
    { value: 'markdown', label: 'Markdown' },
    { value: 'sql', label: 'SQL' },
    { value: 'bash', label: 'Bash' },
  ];
  
  const expiryOptions = [
    { value: 1, label: '1 heure' },
    { value: 6, label: '6 heures' },
    { value: 12, label: '12 heures' },
    { value: 24, label: '24 heures' },
  ];
  
  async function handleImageUpload(event: Event) {
    const input = event.target as HTMLInputElement;
    if (!input.files) return;
    
    const file = input.files[0];
    if (!file) return;
    
    if (images.length >= 5) {
      error = 'Maximum 5 images autorisées';
      return;
    }
    
    if (file.size > 5 * 1024 * 1024) {
      error = 'Image trop volumineuse (max 5MB)';
      return;
    }
    
    error = '';
    isCompressing = file.size > 2 * 1024 * 1024;
    compressionInfo = '';
    
    try {
      if (isCompressing) {
        compressionInfo = `Compression de ${formatFileSize(file.size)}...`;
      }
      
      const result = await compressImage(file);
      
      if (result.wasCompressed) {
        compressionInfo = `Compressé: ${formatFileSize(result.originalSize)} → ${formatFileSize(result.compressedSize)}`;
        setTimeout(() => compressionInfo = '', 3000);
      }
      
      images = [...images, result.base64];
    } catch (e) {
      error = 'Erreur lors du traitement de l\'image';
    } finally {
      isCompressing = false;
    }
    
    // Reset input
    input.value = '';
  }
  
  function removeImage(index: number) {
    images = images.filter((_, i) => i !== index);
  }
  
  async function createPaste() {
    if (!content.trim()) {
      error = 'Le contenu ne peut pas être vide';
      return;
    }
    
    isSubmitting = true;
    error = '';
    
    try {
      const response = await api.post<{ paste_id: string; expires_at: string }>('/paste/', {
        content,
        title: title || null,
        language,
        password: password || null,
        expires_in_hours: expiresInHours,
        burn_after_read: burnAfterRead,
        max_views: maxViews,
        images
      });
      
      createdPaste = response;
    } catch (e) {
      error = e instanceof Error ? e.message : 'Erreur lors de la création';
    } finally {
      isSubmitting = false;
    }
  }
  
  function getPasteUrl(pasteId: string): string {
    return `${window.location.origin}/tools/pastebin/view/${pasteId}`;
  }
  
  async function copyUrl() {
    if (!createdPaste) return;
    await navigator.clipboard.writeText(getPasteUrl(createdPaste.paste_id));
    copied = true;
    setTimeout(() => copied = false, 2000);
  }
  
  function resetForm() {
    content = '';
    title = '';
    language = 'text';
    password = '';
    expiresInHours = 24;
    burnAfterRead = false;
    maxViews = null;
    images = [];
    createdPaste = null;
    error = '';
  }
  
  function getTimeRemaining(expiresAt: string): string {
    const now = new Date();
    const expires = new Date(expiresAt);
    const diff = expires.getTime() - now.getTime();
    
    if (diff <= 0) return 'Expiré';
    
    const hours = Math.floor(diff / (1000 * 60 * 60));
    const minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
    
    if (hours > 0) {
      return `${hours}h ${minutes}min restantes`;
    }
    return `${minutes} minutes restantes`;
  }
</script>

<div class="max-w-4xl mx-auto">
  <!-- Header -->
  <header class="text-center mb-8">
    <h1 class="text-3xl font-bold mb-2">📋 Pastebin Sécurisé</h1>
    <p class="text-base-content/60">Partagez du texte et des images temporairement (max 24h)</p>
  </header>
  
  {#if createdPaste}
    <!-- Success Card -->
    <div class="card bg-success/10 border border-success/30 shadow-xl max-w-lg mx-auto">
      <div class="card-body text-center">
        <div class="text-5xl mb-4">✅</div>
        <h2 class="card-title justify-center text-success">Paste créé avec succès!</h2>
        
        <div class="join w-full mt-4">
          <input 
            type="text" 
            readonly 
            value={getPasteUrl(createdPaste.paste_id)} 
            class="input input-bordered join-item flex-1 font-mono text-sm bg-base-200"
          />
          <button class="btn btn-success join-item" on:click={copyUrl}>
            {copied ? '✅ Copié!' : '📋 Copier'}
          </button>
        </div>
        
        <p class="text-warning mt-4">
          ⏰ Expire dans: {getTimeRemaining(createdPaste.expires_at)}
        </p>
        
        <div class="card-actions justify-center mt-4">
          <button class="btn btn-outline btn-primary" on:click={resetForm}>
            ➕ Créer un nouveau paste
          </button>
          <Link to={`/tools/pastebin/view/${createdPaste.paste_id}`} class="btn btn-ghost">
            👁️ Voir le paste
          </Link>
        </div>
      </div>
    </div>
  {:else}
    <!-- Create Form -->
    <div class="card bg-base-100 shadow-xl">
      <div class="card-body">
        <h2 class="card-title mb-4">Créer un nouveau paste</h2>
        
        <!-- Title & Language Row -->
        <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
          <div class="form-control md:col-span-2">
            <label class="label" for="title">
              <span class="label-text">Titre (optionnel)</span>
            </label>
            <input 
              type="text" 
              id="title"
              bind:value={title} 
              placeholder="Mon paste..." 
              class="input input-bordered"
            />
          </div>
          
          <div class="form-control">
            <label class="label" for="language">
              <span class="label-text">Langage</span>
            </label>
            <select id="language" bind:value={language} class="select select-bordered">
              {#each languages as lang}
                <option value={lang.value}>{lang.label}</option>
              {/each}
            </select>
          </div>
        </div>
        
        <!-- Content -->
        <div class="form-control mt-4">
          <label class="label" for="content">
            <span class="label-text">Contenu *</span>
          </label>
          <textarea 
            id="content"
            bind:value={content} 
            rows="12" 
            placeholder="Collez votre contenu ici..."
            class="textarea textarea-bordered font-mono"
          ></textarea>
        </div>
        
        <!-- Images Upload -->
        <div class="form-control mt-4">
          <label class="label" for="imageUpload">
            <span class="label-text">Images (max 5, 5MB chacune - auto-compressées si &gt;2MB)</span>
            <span class="label-text-alt">{images.length}/5</span>
          </label>
          
          <input 
            type="file"
            id="imageUpload" 
            accept="image/*" 
            on:change={handleImageUpload}
            disabled={images.length >= 5 || isCompressing}
            class="file-input file-input-bordered w-full"
          />
          
          {#if isCompressing}
            <div class="alert alert-info mt-2">
              <span class="loading loading-spinner loading-sm"></span>
              <span>{compressionInfo}</span>
            </div>
          {:else if compressionInfo}
            <div class="alert alert-success mt-2">
              <span>✅ {compressionInfo}</span>
            </div>
          {/if}
          
          {#if images.length > 0}
            <div class="flex flex-wrap gap-2 mt-4">
              {#each images as img, i}
                <div class="relative">
                  <img 
                    src={img} 
                    alt="Aperçu {i + 1}" 
                    class="w-20 h-20 object-cover rounded-lg"
                  />
                  <button 
                    class="btn btn-circle btn-error btn-xs absolute -top-2 -right-2"
                    on:click={() => removeImage(i)}
                  >
                    ×
                  </button>
                </div>
              {/each}
            </div>
          {/if}
        </div>
        
        <!-- Options Grid -->
        <div class="grid grid-cols-1 md:grid-cols-3 gap-4 mt-4">
          <div class="form-control">
            <label class="label" for="password">
              <span class="label-text">🔒 Mot de passe</span>
            </label>
            <input 
              type="password" 
              id="password"
              bind:value={password} 
              placeholder="Optionnel"
              class="input input-bordered"
            />
          </div>
          
          <div class="form-control">
            <label class="label" for="expiry">
              <span class="label-text">⏰ Expiration</span>
            </label>
            <select id="expiry" bind:value={expiresInHours} class="select select-bordered">
              {#each expiryOptions as opt}
                <option value={opt.value}>{opt.label}</option>
              {/each}
            </select>
          </div>
          
          <div class="form-control">
            <label class="label" for="maxViews">
              <span class="label-text">👁️ Vues max</span>
            </label>
            <input 
              type="number" 
              id="maxViews"
              bind:value={maxViews} 
              min="1" 
              placeholder="Illimité"
              class="input input-bordered"
            />
          </div>
        </div>
        
        <!-- Burn after read -->
        <div class="form-control mt-4">
          <label class="label cursor-pointer justify-start gap-4">
            <input type="checkbox" bind:checked={burnAfterRead} class="checkbox checkbox-error" />
            <span class="label-text">🔥 Supprimer après lecture</span>
          </label>
        </div>
        
        <!-- Error -->
        {#if error}
          <div class="alert alert-error mt-4">
            <svg xmlns="http://www.w3.org/2000/svg" class="stroke-current shrink-0 h-6 w-6" fill="none" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z" />
            </svg>
            <span>{error}</span>
          </div>
        {/if}
        
        <!-- Submit -->
        <div class="card-actions justify-end mt-6">
          <button 
            class="btn btn-primary btn-lg gap-2"
            on:click={createPaste}
            disabled={isSubmitting}
          >
            {#if isSubmitting}
              <span class="loading loading-spinner"></span>
              Création...
            {:else}
              🚀 Créer le paste
            {/if}
          </button>
        </div>
      </div>
    </div>
  {/if}
</div>
