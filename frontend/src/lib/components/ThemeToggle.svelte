<script lang="ts">
  import { theme } from '../stores/theme';
  import { onMount } from 'svelte';
  
  let mounted = false;
  
  onMount(() => {
    theme.initialize();
    mounted = true;
  });
</script>

<button
  class="theme-toggle"
  class:dark={$theme === 'dark'}
  on:click={() => theme.toggle()}
  aria-label={$theme === 'dark' ? 'Switch to light mode' : 'Switch to dark mode'}
  title={$theme === 'dark' ? 'Mode clair' : 'Mode sombre'}
>
  <div class="toggle-track">
    <!-- Stars for dark mode -->
    <div class="stars">
      <span class="star star-1">✦</span>
      <span class="star star-2">✧</span>
      <span class="star star-3">✦</span>
    </div>
    
    <!-- Clouds for light mode -->
    <div class="clouds">
      <span class="cloud cloud-1">☁</span>
      <span class="cloud cloud-2">☁</span>
    </div>
    
    <!-- Sun/Moon toggle -->
    <div class="toggle-thumb">
      <div class="sun-moon">
        <!-- Sun rays -->
        <div class="rays">
          {#each Array(8) as _, i}
            <span class="ray" style="--rotation: {i * 45}deg"></span>
          {/each}
        </div>
        <!-- Moon craters -->
        <div class="craters">
          <span class="crater crater-1"></span>
          <span class="crater crater-2"></span>
          <span class="crater crater-3"></span>
        </div>
      </div>
    </div>
  </div>
</button>

<style>
  .theme-toggle {
    --toggle-width: 64px;
    --toggle-height: 32px;
    --thumb-size: 26px;
    --toggle-padding: 3px;
    
    position: relative;
    width: var(--toggle-width);
    height: var(--toggle-height);
    padding: 0;
    border: none;
    background: transparent;
    cursor: pointer;
    outline: none;
  }
  
  .theme-toggle:focus-visible .toggle-track {
    box-shadow: 0 0 0 3px oklch(var(--p) / 0.3);
  }
  
  .toggle-track {
    position: relative;
    width: 100%;
    height: 100%;
    border-radius: 9999px;
    background: linear-gradient(135deg, #87CEEB 0%, #87CEEB 50%, #1e90ff 100%);
    overflow: hidden;
    transition: all 0.5s cubic-bezier(0.4, 0, 0.2, 1);
    box-shadow: 
      inset 0 2px 4px rgba(0, 0, 0, 0.1),
      0 2px 8px rgba(0, 0, 0, 0.1);
  }
  
  .dark .toggle-track {
    background: linear-gradient(135deg, #1a1a2e 0%, #16213e 50%, #0f3460 100%);
  }
  
  /* Stars */
  .stars {
    position: absolute;
    inset: 0;
    opacity: 0;
    transition: opacity 0.4s ease;
  }
  
  .dark .stars {
    opacity: 1;
  }
  
  .star {
    position: absolute;
    color: #ffd700;
    font-size: 8px;
    animation: twinkle 2s ease-in-out infinite;
  }
  
  .star-1 { top: 6px; right: 10px; animation-delay: 0s; }
  .star-2 { top: 14px; right: 18px; font-size: 6px; animation-delay: 0.5s; }
  .star-3 { top: 8px; right: 26px; font-size: 5px; animation-delay: 1s; }
  
  @keyframes twinkle {
    0%, 100% { opacity: 0.5; transform: scale(1); }
    50% { opacity: 1; transform: scale(1.2); }
  }
  
  /* Clouds */
  .clouds {
    position: absolute;
    inset: 0;
    opacity: 1;
    transition: opacity 0.4s ease;
  }
  
  .dark .clouds {
    opacity: 0;
  }
  
  .cloud {
    position: absolute;
    color: rgba(255, 255, 255, 0.9);
    font-size: 14px;
    animation: float 3s ease-in-out infinite;
  }
  
  .cloud-1 { top: 2px; right: 8px; animation-delay: 0s; }
  .cloud-2 { top: 12px; right: 20px; font-size: 10px; animation-delay: 1s; }
  
  @keyframes float {
    0%, 100% { transform: translateY(0); }
    50% { transform: translateY(-2px); }
  }
  
  /* Toggle thumb (sun/moon) */
  .toggle-thumb {
    position: absolute;
    top: var(--toggle-padding);
    left: var(--toggle-padding);
    width: var(--thumb-size);
    height: var(--thumb-size);
    border-radius: 50%;
    background: linear-gradient(135deg, #FFD700 0%, #FFA500 100%);
    box-shadow: 
      0 2px 10px rgba(255, 165, 0, 0.5),
      inset 0 -2px 4px rgba(0, 0, 0, 0.1);
    transition: all 0.5s cubic-bezier(0.4, 0, 0.2, 1);
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
  }
  
  .dark .toggle-thumb {
    left: calc(100% - var(--thumb-size) - var(--toggle-padding));
    background: linear-gradient(135deg, #e8e8e8 0%, #c0c0c0 100%);
    box-shadow: 
      0 2px 10px rgba(200, 200, 200, 0.3),
      inset 0 -2px 4px rgba(0, 0, 0, 0.2);
  }
  
  .sun-moon {
    position: relative;
    width: 100%;
    height: 100%;
  }
  
  /* Sun rays */
  .rays {
    position: absolute;
    inset: -4px;
    transition: all 0.5s cubic-bezier(0.4, 0, 0.2, 1);
  }
  
  .dark .rays {
    opacity: 0;
    transform: scale(0);
  }
  
  .ray {
    position: absolute;
    top: 50%;
    left: 50%;
    width: 3px;
    height: 6px;
    background: #FFD700;
    border-radius: 2px;
    transform-origin: center center;
    transform: translate(-50%, -50%) rotate(var(--rotation)) translateY(-14px);
    animation: pulse-ray 2s ease-in-out infinite;
  }
  
  @keyframes pulse-ray {
    0%, 100% { opacity: 0.7; height: 6px; }
    50% { opacity: 1; height: 8px; }
  }
  
  /* Moon craters */
  .craters {
    position: absolute;
    inset: 0;
    opacity: 0;
    transition: opacity 0.5s ease;
  }
  
  .dark .craters {
    opacity: 1;
  }
  
  .crater {
    position: absolute;
    border-radius: 50%;
    background: rgba(100, 100, 100, 0.3);
  }
  
  .crater-1 { width: 6px; height: 6px; top: 6px; left: 8px; }
  .crater-2 { width: 4px; height: 4px; top: 14px; left: 14px; }
  .crater-3 { width: 3px; height: 3px; top: 8px; left: 16px; }
  
  /* Hover effect */
  .theme-toggle:hover .toggle-thumb {
    transform: scale(1.05);
  }
  
  .dark .theme-toggle:hover .toggle-thumb {
    transform: translateX(0) scale(1.05);
  }
  
  /* Active press effect */
  .theme-toggle:active .toggle-thumb {
    transform: scale(0.95);
  }
</style>
