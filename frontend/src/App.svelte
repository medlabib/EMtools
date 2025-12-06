<script lang="ts">
  import { Router, Route, navigate } from 'svelte-routing';
  import { isLoading } from 'svelte-i18n';
  import { authStore, checkAuth } from './lib/stores/auth';
  import { checkSetupStatus } from './lib/stores/admin';
  import { onMount } from 'svelte';
  
  import Layout from './lib/components/Layout.svelte';
  import ProtectedRoute from './lib/components/ProtectedRoute.svelte';
  import AdminProtectedRoute from './lib/components/AdminProtectedRoute.svelte';
  import Home from './lib/pages/Home.svelte';
  import Login from './lib/pages/Login.svelte';
  import Register from './lib/pages/Register.svelte';
  import Tools from './lib/pages/Tools.svelte';
  import PasteView from './lib/pages/tools/PasteView.svelte';
  import NotFound from './lib/pages/NotFound.svelte';
  import Setup from './lib/pages/Setup.svelte';
  
  export let url = '';
  
  let setupChecked = false;
  let needsSetup = false;
  
  onMount(async () => {
    // Check if initial setup is required
    try {
      const status = await checkSetupStatus();
      needsSetup = !status.is_setup_complete;
      if (needsSetup && !window.location.pathname.startsWith('/setup')) {
        navigate('/setup', { replace: true });
      }
    } catch (e) {
      // API might be down or setup endpoint doesn't exist, continue normally
    }
    setupChecked = true;
    checkAuth();
  });
</script>

{#if $isLoading || !setupChecked}
  <div class="flex justify-center items-center h-screen">
    <span class="loading loading-spinner loading-lg text-primary"></span>
  </div>
{:else}
  <Router {url}>
    <Layout>
      <Route path="/" component={Home} />
      <Route path="/login" component={Login} />
      <Route path="/register" component={Register} />
      <Route path="/setup" component={Setup} />
      <Route path="/dashboard"><ProtectedRoute component={Tools} /></Route>
      <Route path="/tools/medical-report"><ProtectedRoute loader={() => import('./lib/pages/tools/MedicalReport.svelte')} /></Route>
      <Route path="/tools/pastebin"><ProtectedRoute loader={() => import('./lib/pages/tools/Pastebin.svelte')} /></Route>
      <Route path="/tools/pastebin/view/:id" let:params><PasteView pasteId={params.id} /></Route>
      <Route path="/tools/medical-calculator"><ProtectedRoute loader={() => import('./lib/pages/tools/MedicalCalculator.svelte')} /></Route>
      <Route path="/tools/vasoactive-drugs"><ProtectedRoute loader={() => import('./lib/pages/tools/VasoactiveDrugs.svelte')} /></Route>
      <Route path="/tools/sedation"><ProtectedRoute loader={() => import('./lib/pages/tools/Sedation.svelte')} /></Route>
      <Route path="/tools/metabolic-disorders"><ProtectedRoute loader={() => import('./lib/pages/tools/MetabolicDisorders.svelte')} /></Route>
      <Route path="/tools/blood-gas"><ProtectedRoute loader={() => import('./lib/pages/tools/BloodGasVentilation.svelte')} /></Route>
      <Route path="/tools/antibiotic-guide"><ProtectedRoute loader={() => import('./lib/pages/tools/AntibioticGuide.svelte')} /></Route>
      
      <!-- Admin routes -->
      <Route path="/admin"><AdminProtectedRoute loader={() => import('./lib/pages/admin/AdminDashboard.svelte')} /></Route>
      <Route path="/admin/users"><AdminProtectedRoute loader={() => import('./lib/pages/admin/AdminUsers.svelte')} /></Route>
      <Route path="/admin/settings"><AdminProtectedRoute loader={() => import('./lib/pages/admin/AdminSettings.svelte')} /></Route>
      <Route path="/admin/logs"><AdminProtectedRoute loader={() => import('./lib/pages/admin/AdminLogs.svelte')} /></Route>
      
      <Route path="*" component={NotFound} />
    </Layout>
  </Router>
{/if}
