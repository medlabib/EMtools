<script lang="ts">
  import { Router, Route } from 'svelte-routing';
  import { isLoading } from 'svelte-i18n';
  import { authStore, checkAuth } from './lib/stores/auth';
  import { onMount } from 'svelte';
  
  import Layout from './lib/components/Layout.svelte';
  import Home from './lib/pages/Home.svelte';
  import Login from './lib/pages/Login.svelte';
  import Register from './lib/pages/Register.svelte';
  import Dashboard from './lib/pages/Dashboard.svelte';
  import AdminDashboard from './lib/pages/admin/AdminDashboard.svelte';
  import AdminUsers from './lib/pages/admin/AdminUsers.svelte';
  import NotFound from './lib/pages/NotFound.svelte';
  
  export let url = '';
  
  onMount(() => {
    checkAuth();
  });
</script>

{#if $isLoading}
  <div class="loading">Loading...</div>
{:else}
  <Router {url}>
    <Layout>
      <Route path="/" component={Home} />
      <Route path="/login" component={Login} />
      <Route path="/register" component={Register} />
      <Route path="/dashboard" component={Dashboard} />
      <Route path="/admin" component={AdminDashboard} />
      <Route path="/admin/users" component={AdminUsers} />
      <Route path="*" component={NotFound} />
    </Layout>
  </Router>
{/if}

<style>
  .loading {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    font-size: 1.5rem;
  }
</style>
