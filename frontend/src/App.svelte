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
  import MedicalReport from './lib/pages/tools/MedicalReport.svelte';
  import Pastebin from './lib/pages/tools/Pastebin.svelte';
  import PasteView from './lib/pages/tools/PasteView.svelte';
  import MedicalCalculator from './lib/pages/tools/MedicalCalculator.svelte';
  import VasoactiveDrugs from './lib/pages/tools/VasoactiveDrugs.svelte';
  import Sedation from './lib/pages/tools/Sedation.svelte';
  import MetabolicDisorders from './lib/pages/tools/MetabolicDisorders.svelte';
  import BloodGasVentilation from './lib/pages/tools/BloodGasVentilation.svelte';
  import AntibioticGuide from './lib/pages/tools/AntibioticGuide.svelte';
  import NotFound from './lib/pages/NotFound.svelte';
  
  // Admin pages
  import Setup from './lib/pages/Setup.svelte';
  import AdminDashboard from './lib/pages/admin/AdminDashboard.svelte';
  import AdminUsers from './lib/pages/admin/AdminUsers.svelte';
  import AdminSettings from './lib/pages/admin/AdminSettings.svelte';
  import AdminLogs from './lib/pages/admin/AdminLogs.svelte';
  
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
      <Route path="/tools/medical-report"><ProtectedRoute component={MedicalReport} /></Route>
      <Route path="/tools/pastebin"><ProtectedRoute component={Pastebin} /></Route>
      <Route path="/tools/pastebin/view/:id" let:params><PasteView pasteId={params.id} /></Route>
      <Route path="/tools/medical-calculator"><ProtectedRoute component={MedicalCalculator} /></Route>
      <Route path="/tools/vasoactive-drugs"><ProtectedRoute component={VasoactiveDrugs} /></Route>
      <Route path="/tools/sedation"><ProtectedRoute component={Sedation} /></Route>
      <Route path="/tools/metabolic-disorders"><ProtectedRoute component={MetabolicDisorders} /></Route>
      <Route path="/tools/blood-gas"><ProtectedRoute component={BloodGasVentilation} /></Route>
      <Route path="/tools/antibiotic-guide"><ProtectedRoute component={AntibioticGuide} /></Route>
      
      <!-- Admin routes -->
      <Route path="/admin"><AdminProtectedRoute component={AdminDashboard} /></Route>
      <Route path="/admin/users"><AdminProtectedRoute component={AdminUsers} /></Route>
      <Route path="/admin/settings"><AdminProtectedRoute component={AdminSettings} /></Route>
      <Route path="/admin/logs"><AdminProtectedRoute component={AdminLogs} /></Route>
      
      <Route path="*" component={NotFound} />
    </Layout>
  </Router>
{/if}
