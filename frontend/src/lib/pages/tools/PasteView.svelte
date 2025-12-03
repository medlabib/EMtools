<script lang="ts">
  import { onMount } from 'svelte';
  import { Link } from 'svelte-routing';
  import { api } from '../../api';
  
  export let pasteId: string;
  
  // State
  let paste: any = null;
  let error = '';
  let isLoading = true;
  let needsPassword = false;
  let password = '';
  let isUnlocking = false;
  
  onMount(async () => {
    await checkPaste();
  });
  
  async function checkPaste() {
    if (!pasteId) {
      error = 'ID de paste invalide';
      isLoading = false;
      return;
    }
    
    isLoading = true;
    error = '';
    
    try {
      // First check paste info
      const info = await api.get<{ is_protected: boolean }>(`/paste/${pasteId}`);
      
      if (info.is_protected) {
        needsPassword = true;
        isLoading = false;
        return;
      }
      
      // Access paste content without password
      await accessPaste();
    } catch (e: any) {
      error = e.message || 'Paste non trouvé ou expiré';
      isLoading = false;
    }
  }
  
  async function accessPaste() {
    isUnlocking = true;
    error = '';
    
    try {
      const response = await api.post<any>(`/paste/${pasteId}/access`, {
        password: password || null
      });
      
      paste = response;
      needsPassword = false;
    } catch (e: any) {
      if (e.message?.includes('Password') || e.message?.includes('password')) {
        needsPassword = true;
        error = 'Mot de passe incorrect';
      } else {
        error = e.message || 'Impossible d\'accéder au paste';
      }
    } finally {
      isLoading = false;
      isUnlocking = false;
    }
  }
  
  function formatDate(dateStr: string): string {
    return new Date(dateStr).toLocaleString('fr-FR');
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
  
  function downloadImage(base64: string, index: number) {
    // Extract mime type and data
    const match = base64.match(/^data:(.+);base64,(.+)$/);
    if (!match) return;
    
    const mimeType = match[1];
    const extension = mimeType.split('/')[1] || 'png';
    
    // Create download link
    const link = document.createElement('a');
    link.href = base64;
    link.download = `image-${index + 1}.${extension}`;
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
  }
  
  function copyContent() {
    if (paste?.content) {
      navigator.clipboard.writeText(paste.content);
    }
  }
</script>

<div class="max-w-4xl mx-auto p-4 md:p-8">
  <!-- Header -->
  <div class="flex items-center gap-4 mb-6">
    <Link to="/tools/pastebin" class="btn btn-ghost btn-sm gap-2">
      <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
      </svg>
      Retour
    </Link>
    <h1 class="text-2xl font-bold">📋 Pastebin</h1>
  </div>
  
  <!-- Loading State -->
  {#if isLoading}
    <div class="flex flex-col items-center justify-center min-h-[40vh] gap-4">
      <span class="loading loading-spinner loading-lg text-primary"></span>
      <p class="text-base-content/60">Chargement du paste...</p>
    </div>
  
  <!-- Password Required -->
  {:else if needsPassword}
    <div class="card bg-base-100 shadow-xl max-w-md mx-auto">
      <div class="card-body text-center">
        <div class="text-5xl mb-4">🔒</div>
        <h2 class="card-title justify-center">Paste protégé</h2>
        <p class="text-base-content/60 mb-4">Ce paste est protégé par un mot de passe</p>
        
        {#if error}
          <div class="alert alert-error mb-4">
            <svg xmlns="http://www.w3.org/2000/svg" class="stroke-current shrink-0 h-6 w-6" fill="none" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z" />
            </svg>
            <span>{error}</span>
          </div>
        {/if}
        
        <div class="form-control">
          <input 
            type="password" 
            bind:value={password}
            placeholder="Mot de passe"
            class="input input-bordered w-full"
            on:keydown={(e) => e.key === 'Enter' && accessPaste()}
          />
        </div>
        
        <div class="card-actions justify-center mt-4">
          <button 
            class="btn btn-primary gap-2"
            on:click={accessPaste}
            disabled={isUnlocking}
          >
            {#if isUnlocking}
              <span class="loading loading-spinner loading-sm"></span>
            {:else}
              🔓
            {/if}
            Déverrouiller
          </button>
        </div>
      </div>
    </div>
  
  <!-- Error State -->
  {:else if error}
    <div class="card bg-base-100 shadow-xl max-w-md mx-auto">
      <div class="card-body text-center">
        <div class="text-5xl mb-4">❌</div>
        <h2 class="card-title justify-center text-error">Erreur</h2>
        <p class="text-base-content/60">{error}</p>
        <div class="card-actions justify-center mt-4">
          <Link to="/tools/pastebin" class="btn btn-primary">
            Créer un nouveau paste
          </Link>
        </div>
      </div>
    </div>
  
  <!-- Paste Content -->
  {:else if paste}
    <div class="card bg-base-100 shadow-xl">
      <!-- Header -->
      <div class="card-body pb-0">
        <div class="flex flex-wrap items-center justify-between gap-4">
          <div>
            <h2 class="card-title text-xl">{paste.title || 'Sans titre'}</h2>
            <div class="badge badge-primary">{paste.language}</div>
          </div>
          <button class="btn btn-ghost btn-sm gap-2" on:click={copyContent}>
            📋 Copier
          </button>
        </div>
        
        <!-- Meta info -->
        <div class="flex flex-wrap gap-4 text-sm text-base-content/60 mt-2">
          <span>📅 {formatDate(paste.created_at)}</span>
          <span>⏰ {getTimeRemaining(paste.expires_at)}</span>
          <span>👁️ Vues: {paste.views}{paste.max_views ? `/${paste.max_views}` : ''}</span>
          {#if paste.burn_after_read}
            <span class="text-error font-semibold">🔥 Supprimé après lecture!</span>
          {/if}
        </div>
      </div>
      
      <div class="divider my-2"></div>
      
      <!-- Content -->
      <div class="px-6 pb-6">
        <div class="mockup-code bg-base-200 overflow-x-auto max-h-[500px] overflow-y-auto">
          <pre class="px-4"><code>{paste.content}</code></pre>
        </div>
      </div>
      
      <!-- Images -->
      {#if paste.images && paste.images.length > 0}
        <div class="divider my-2"></div>
        <div class="px-6 pb-6">
          <h3 class="font-semibold mb-4">📷 Images attachées ({paste.images.length})</h3>
          <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-4">
            {#each paste.images as img, i}
              <div class="relative group">
                <figure class="rounded-lg overflow-hidden bg-base-200">
                  <button 
                    type="button"
                    class="w-full h-48 p-0 border-0 bg-transparent cursor-pointer"
                    on:click={() => window.open(img, '_blank')}
                    aria-label="Voir image {i + 1} en plein écran"
                  >
                    <img 
                      src={img} 
                      alt="Pièce jointe {i + 1}" 
                      class="w-full h-full object-cover hover:scale-105 transition-transform"
                    />
                  </button>
                </figure>
                <div class="absolute bottom-2 right-2 opacity-0 group-hover:opacity-100 transition-opacity">
                  <button 
                    class="btn btn-sm btn-primary gap-1"
                    on:click={() => downloadImage(img, i)}
                  >
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4" />
                    </svg>
                    Télécharger
                  </button>
                </div>
              </div>
            {/each}
          </div>
        </div>
      {/if}
    </div>
    
    <!-- Burn warning -->
    {#if paste.burn_after_read}
      <div class="alert alert-warning mt-4">
        <svg xmlns="http://www.w3.org/2000/svg" class="stroke-current shrink-0 h-6 w-6" fill="none" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
        </svg>
        <span>Ce paste sera supprimé après cette lecture. Sauvegardez le contenu si nécessaire.</span>
      </div>
    {/if}
  {/if}
</div>
