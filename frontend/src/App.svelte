<script lang="ts">
  import { Router, Route } from 'svelte-routing';
  import { isLoading } from 'svelte-i18n';
  import { authStore, checkAuth } from './lib/stores/auth';
  import { onMount } from 'svelte';
  
  import Layout from './lib/components/Layout.svelte';
  import ProtectedRoute from './lib/components/ProtectedRoute.svelte';
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
  
  export let url = '';
  
  onMount(() => {
    checkAuth();
  });
</script>

{#if $isLoading}
  <div class="flex justify-center items-center h-screen">
    <span class="loading loading-spinner loading-lg text-primary"></span>
  </div>
{:else}
  <Router {url}>
    <Layout>
      <Route path="/" component={Home} />
      <Route path="/login" component={Login} />
      <Route path="/register" component={Register} />
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
      <Route path="*" component={NotFound} />
    </Layout>
  </Router>
{/if}
