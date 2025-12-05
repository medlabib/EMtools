<script lang="ts">
  import { onMount } from 'svelte';
  import { navigate } from 'svelte-routing';
  import { authStore, isAdmin } from '../../stores/auth';
  import { 
    fetchUsers, 
    fetchUsersCount,
    createUser,
    updateUser,
    deleteUser,
    adminUsers,
    type AdminUser 
  } from '../../stores/admin';

  let loading = true;
  let error = '';
  let totalUsers = 0;
  let currentPage = 1;
  let pageSize = 20;
  let filterRole: 'all' | 'admin' | 'user' = 'all';
  let filterActive: 'all' | 'active' | 'inactive' = 'all';
  let searchQuery = '';
  let searchTimeout: ReturnType<typeof setTimeout>;

  // Modal state
  let showCreateModal = false;
  let showEditModal = false;
  let showDeleteModal = false;
  let selectedUser: AdminUser | null = null;
  let modalLoading = false;
  let modalError = '';

  // Form data
  let formData = {
    email: '',
    username: '',
    password: '',
    role: 'user' as 'admin' | 'user',
    is_verified: true,
    is_active: true
  };

  onMount(async () => {
    if (!$authStore.isAuthenticated || !isAdmin($authStore.user)) {
      navigate('/login');
      return;
    }
    await loadUsers();
  });

  async function loadUsers() {
    loading = true;
    error = '';
    try {
      const params: Record<string, unknown> = {
        skip: (currentPage - 1) * pageSize,
        limit: pageSize
      };
      if (filterRole !== 'all') params.role = filterRole;
      if (filterActive !== 'all') params.is_active = filterActive === 'active';

      await fetchUsers(params as Parameters<typeof fetchUsers>[0]);
      totalUsers = await fetchUsersCount(
        filterRole !== 'all' || filterActive !== 'all' 
          ? { role: filterRole !== 'all' ? filterRole : undefined, is_active: filterActive !== 'all' ? filterActive === 'active' : undefined }
          : undefined
      );
    } catch (e) {
      error = e instanceof Error ? e.message : 'Failed to load users';
    } finally {
      loading = false;
    }
  }

  function openCreateModal() {
    formData = {
      email: '',
      username: '',
      password: '',
      role: 'user',
      is_verified: true,
      is_active: true
    };
    modalError = '';
    showCreateModal = true;
  }

  function openEditModal(user: AdminUser) {
    selectedUser = user;
    formData = {
      email: user.email,
      username: user.username,
      password: '',
      role: user.role,
      is_verified: user.is_verified,
      is_active: user.is_active
    };
    modalError = '';
    showEditModal = true;
  }

  function openDeleteModal(user: AdminUser) {
    selectedUser = user;
    showDeleteModal = true;
  }

  async function handleCreate() {
    modalLoading = true;
    modalError = '';
    try {
      await createUser(formData);
      showCreateModal = false;
      await loadUsers();
    } catch (e) {
      modalError = e instanceof Error ? e.message : 'Failed to create user';
    } finally {
      modalLoading = false;
    }
  }

  async function handleUpdate() {
    if (!selectedUser) return;
    modalLoading = true;
    modalError = '';
    try {
      const updateData: Parameters<typeof updateUser>[1] = {};
      if (formData.email !== selectedUser.email) updateData.email = formData.email;
      if (formData.username !== selectedUser.username) updateData.username = formData.username;
      if (formData.password) updateData.password = formData.password;
      if (formData.role !== selectedUser.role) updateData.role = formData.role;
      if (formData.is_verified !== selectedUser.is_verified) updateData.is_verified = formData.is_verified;
      if (formData.is_active !== selectedUser.is_active) updateData.is_active = formData.is_active;

      await updateUser(selectedUser.id, updateData);
      showEditModal = false;
      selectedUser = null;
      await loadUsers();
    } catch (e) {
      modalError = e instanceof Error ? e.message : 'Failed to update user';
    } finally {
      modalLoading = false;
    }
  }

  async function handleDelete() {
    if (!selectedUser) return;
    modalLoading = true;
    try {
      await deleteUser(selectedUser.id);
      showDeleteModal = false;
      selectedUser = null;
      await loadUsers();
    } catch (e) {
      error = e instanceof Error ? e.message : 'Failed to delete user';
    } finally {
      modalLoading = false;
    }
  }

  function formatDate(dateStr: string): string {
    return new Date(dateStr).toLocaleDateString('fr-FR', {
      day: '2-digit',
      month: '2-digit',
      year: 'numeric'
    });
  }

  function handleSearch() {
    clearTimeout(searchTimeout);
    searchTimeout = setTimeout(() => {
      currentPage = 1;
      loadUsers();
    }, 300);
  }

  function clearSearch() {
    searchQuery = '';
    currentPage = 1;
    loadUsers();
  }

  // Client-side filtering for search (since backend may not support search)
  $: filteredUsers = searchQuery 
    ? $adminUsers.filter(user => 
        user.email.toLowerCase().includes(searchQuery.toLowerCase()) ||
        user.username.toLowerCase().includes(searchQuery.toLowerCase()) ||
        (user.full_name?.toLowerCase().includes(searchQuery.toLowerCase()))
      )
    : $adminUsers;

  $: totalPages = Math.ceil(totalUsers / pageSize);
</script>

<div class="min-h-screen bg-base-200">
  <!-- Header -->
  <div class="bg-base-100 shadow-sm border-b border-base-300">
    <div class="container mx-auto px-4 py-4">
      <div class="flex items-center justify-between">
        <div class="flex items-center gap-3">
          <a href="/admin" class="btn btn-ghost btn-sm btn-square">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
            </svg>
          </a>
          <div>
            <h1 class="text-2xl font-bold">Gestion des utilisateurs</h1>
            <p class="text-base-content/60 text-sm">{totalUsers} utilisateur{totalUsers > 1 ? 's' : ''}</p>
          </div>
        </div>
        <button class="btn btn-primary btn-sm" on:click={openCreateModal}>
          <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" />
          </svg>
          Nouveau
        </button>
      </div>
    </div>
  </div>

  <div class="container mx-auto px-4 py-6">
    <!-- Filters -->
    <div class="card bg-base-100 shadow-sm mb-4">
      <div class="card-body p-4">
        <div class="flex flex-wrap gap-4 items-end">
          <!-- Search -->
          <div class="form-control flex-1 min-w-[200px]">
            <label class="label label-text text-xs">Rechercher</label>
            <div class="relative">
              <input 
                type="text" 
                class="input input-bordered input-sm w-full pr-8" 
                placeholder="Email, nom d'utilisateur..."
                bind:value={searchQuery}
                on:input={handleSearch}
              />
              {#if searchQuery}
                <button 
                  class="absolute right-2 top-1/2 -translate-y-1/2 btn btn-ghost btn-xs btn-circle"
                  on:click={clearSearch}
                >
                  ✕
                </button>
              {:else}
                <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 absolute right-3 top-1/2 -translate-y-1/2 text-base-content/40" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                </svg>
              {/if}
            </div>
          </div>
          
          <div class="form-control">
            <label class="label label-text text-xs">Rôle</label>
            <select class="select select-bordered select-sm" bind:value={filterRole} on:change={loadUsers}>
              <option value="all">Tous</option>
              <option value="admin">Admin</option>
              <option value="user">Utilisateur</option>
            </select>
          </div>
          <div class="form-control">
            <label class="label label-text text-xs">Statut</label>
            <select class="select select-bordered select-sm" bind:value={filterActive} on:change={loadUsers}>
              <option value="all">Tous</option>
              <option value="active">Actif</option>
              <option value="inactive">Inactif</option>
            </select>
          </div>
          
          <button class="btn btn-outline btn-sm" on:click={loadUsers}>
            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15" />
            </svg>
          </button>
        </div>
      </div>
    </div>

    {#if loading}
      <div class="flex justify-center items-center h-64">
        <span class="loading loading-spinner loading-lg text-primary"></span>
      </div>
    {:else if error}
      <div class="alert alert-error mb-4">
        <span>{error}</span>
      </div>
    {:else}
      <!-- Users Table -->
      <div class="card bg-base-100 shadow-sm">
        <div class="card-body p-0">
          <div class="overflow-x-auto">
            <table class="table">
              <thead>
                <tr>
                  <th>Utilisateur</th>
                  <th>Email</th>
                  <th>Rôle</th>
                  <th>Statut</th>
                  <th>Créé le</th>
                  <th class="text-right">Actions</th>
                </tr>
              </thead>
              <tbody>
                {#each filteredUsers as user}
                  <tr class="hover:bg-base-200/30">
                    <td>
                      <div class="flex items-center gap-3">
                        <div class="avatar placeholder">
                          <div class="bg-neutral text-neutral-content rounded-full w-10">
                            <span class="text-sm">{user.username.charAt(0).toUpperCase()}</span>
                          </div>
                        </div>
                        <div>
                          <div class="font-bold">{user.username}</div>
                          {#if user.full_name}
                            <div class="text-sm opacity-50">{user.full_name}</div>
                          {/if}
                        </div>
                      </div>
                    </td>
                    <td>
                      <span class="text-sm">{user.email}</span>
                      {#if user.is_verified}
                        <span class="ml-1" title="Email vérifié">✓</span>
                      {/if}
                    </td>
                    <td>
                      <span class="badge {user.role === 'admin' ? 'badge-primary' : 'badge-ghost'} badge-sm">
                        {user.role === 'admin' ? 'Admin' : 'Utilisateur'}
                      </span>
                    </td>
                    <td>
                      <span class="badge {user.is_active ? 'badge-success' : 'badge-error'} badge-sm">
                        {user.is_active ? 'Actif' : 'Inactif'}
                      </span>
                    </td>
                    <td class="text-sm text-base-content/70">{formatDate(user.created_at)}</td>
                    <td class="text-right">
                      <div class="dropdown dropdown-end">
                        <button tabindex="0" class="btn btn-ghost btn-sm btn-square">
                          <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 5v.01M12 12v.01M12 19v.01M12 6a1 1 0 110-2 1 1 0 010 2zm0 7a1 1 0 110-2 1 1 0 010 2zm0 7a1 1 0 110-2 1 1 0 010 2z" />
                          </svg>
                        </button>
                        <ul tabindex="0" class="dropdown-content z-[1] menu p-2 shadow bg-base-100 rounded-box w-40">
                          <li><button on:click={() => openEditModal(user)}>Modifier</button></li>
                          {#if user.id !== $authStore.user?.id}
                            <li><button class="text-error" on:click={() => openDeleteModal(user)}>Supprimer</button></li>
                          {/if}
                        </ul>
                      </div>
                    </td>
                  </tr>
                {:else}
                  <tr>
                    <td colspan="6" class="text-center text-base-content/60 py-8">Aucun utilisateur trouvé</td>
                  </tr>
                {/each}
              </tbody>
            </table>
          </div>
        </div>
      </div>

      <!-- Pagination -->
      {#if totalPages > 1}
        <div class="flex justify-center mt-4">
          <div class="join">
            <button 
              class="join-item btn btn-sm" 
              disabled={currentPage === 1}
              on:click={() => { currentPage--; loadUsers(); }}
            >«</button>
            <button class="join-item btn btn-sm">Page {currentPage}/{totalPages}</button>
            <button 
              class="join-item btn btn-sm" 
              disabled={currentPage === totalPages}
              on:click={() => { currentPage++; loadUsers(); }}
            >»</button>
          </div>
        </div>
      {/if}
    {/if}
  </div>
</div>

<!-- Create Modal -->
{#if showCreateModal}
  <div class="modal modal-open">
    <div class="modal-box">
      <h3 class="font-bold text-lg mb-4">Créer un utilisateur</h3>
      
      {#if modalError}
        <div class="alert alert-error mb-4 text-sm">{modalError}</div>
      {/if}

      <form on:submit|preventDefault={handleCreate}>
        <div class="form-control mb-3">
          <label class="label"><span class="label-text">Email *</span></label>
          <input type="email" class="input input-bordered" bind:value={formData.email} required />
        </div>
        <div class="form-control mb-3">
          <label class="label"><span class="label-text">Nom d'utilisateur *</span></label>
          <input type="text" class="input input-bordered" bind:value={formData.username} required minlength="3" />
        </div>
        <div class="form-control mb-3">
          <label class="label"><span class="label-text">Mot de passe *</span></label>
          <input type="password" class="input input-bordered" bind:value={formData.password} required minlength="8" />
        </div>
        <div class="form-control mb-3">
          <label class="label"><span class="label-text">Rôle</span></label>
          <select class="select select-bordered" bind:value={formData.role}>
            <option value="user">Utilisateur</option>
            <option value="admin">Admin</option>
          </select>
        </div>
        <div class="form-control mb-3">
          <label class="label cursor-pointer justify-start gap-3">
            <input type="checkbox" class="checkbox checkbox-primary" bind:checked={formData.is_verified} />
            <span class="label-text">Email vérifié</span>
          </label>
        </div>
        <div class="form-control mb-4">
          <label class="label cursor-pointer justify-start gap-3">
            <input type="checkbox" class="checkbox checkbox-primary" bind:checked={formData.is_active} />
            <span class="label-text">Compte actif</span>
          </label>
        </div>

        <div class="modal-action">
          <button type="button" class="btn" on:click={() => showCreateModal = false}>Annuler</button>
          <button type="submit" class="btn btn-primary" disabled={modalLoading}>
            {#if modalLoading}<span class="loading loading-spinner loading-sm"></span>{/if}
            Créer
          </button>
        </div>
      </form>
    </div>
    <div class="modal-backdrop" on:click={() => showCreateModal = false} on:keydown={() => {}}></div>
  </div>
{/if}

<!-- Edit Modal -->
{#if showEditModal && selectedUser}
  <div class="modal modal-open">
    <div class="modal-box">
      <h3 class="font-bold text-lg mb-4">Modifier l'utilisateur</h3>
      
      {#if modalError}
        <div class="alert alert-error mb-4 text-sm">{modalError}</div>
      {/if}

      <form on:submit|preventDefault={handleUpdate}>
        <div class="form-control mb-3">
          <label class="label"><span class="label-text">Email</span></label>
          <input type="email" class="input input-bordered" bind:value={formData.email} required />
        </div>
        <div class="form-control mb-3">
          <label class="label"><span class="label-text">Nom d'utilisateur</span></label>
          <input type="text" class="input input-bordered" bind:value={formData.username} required minlength="3" />
        </div>
        <div class="form-control mb-3">
          <label class="label"><span class="label-text">Nouveau mot de passe (laisser vide pour ne pas modifier)</span></label>
          <input type="password" class="input input-bordered" bind:value={formData.password} minlength="8" />
        </div>
        <div class="form-control mb-3">
          <label class="label"><span class="label-text">Rôle</span></label>
          <select class="select select-bordered" bind:value={formData.role} disabled={selectedUser.id === $authStore.user?.id}>
            <option value="user">Utilisateur</option>
            <option value="admin">Admin</option>
          </select>
        </div>
        <div class="form-control mb-3">
          <label class="label cursor-pointer justify-start gap-3">
            <input type="checkbox" class="checkbox checkbox-primary" bind:checked={formData.is_verified} />
            <span class="label-text">Email vérifié</span>
          </label>
        </div>
        <div class="form-control mb-4">
          <label class="label cursor-pointer justify-start gap-3">
            <input type="checkbox" class="checkbox checkbox-primary" bind:checked={formData.is_active} disabled={selectedUser.id === $authStore.user?.id} />
            <span class="label-text">Compte actif</span>
          </label>
        </div>

        <div class="modal-action">
          <button type="button" class="btn" on:click={() => { showEditModal = false; selectedUser = null; }}>Annuler</button>
          <button type="submit" class="btn btn-primary" disabled={modalLoading}>
            {#if modalLoading}<span class="loading loading-spinner loading-sm"></span>{/if}
            Enregistrer
          </button>
        </div>
      </form>
    </div>
    <div class="modal-backdrop" on:click={() => { showEditModal = false; selectedUser = null; }} on:keydown={() => {}}></div>
  </div>
{/if}

<!-- Delete Confirmation Modal -->
{#if showDeleteModal && selectedUser}
  <div class="modal modal-open">
    <div class="modal-box">
      <h3 class="font-bold text-lg">Supprimer l'utilisateur</h3>
      <p class="py-4">
        Êtes-vous sûr de vouloir supprimer l'utilisateur <strong>{selectedUser.username}</strong> ({selectedUser.email}) ?
        Cette action est irréversible.
      </p>
      <div class="modal-action">
        <button class="btn" on:click={() => { showDeleteModal = false; selectedUser = null; }}>Annuler</button>
        <button class="btn btn-error" on:click={handleDelete} disabled={modalLoading}>
          {#if modalLoading}<span class="loading loading-spinner loading-sm"></span>{/if}
          Supprimer
        </button>
      </div>
    </div>
    <div class="modal-backdrop" on:click={() => { showDeleteModal = false; selectedUser = null; }} on:keydown={() => {}}></div>
  </div>
{/if}
