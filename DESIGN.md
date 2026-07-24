# EMtools — Design System

> Living design reference for EMtools. Every color, type, and spacing decision in
> the app should trace back to a token defined here. When in doubt, this file wins.

## 1. The brief

**Subject.** EMtools is an emergency-medicine toolkit: scores, calculators, drug
dosing, blood-gas interpretation, resuscitation timers, and clinical protocols.

**Audience.** ER / ICU / prehospital clinicians — physicians, residents, nurses —
using it at the point of care, often one-handed, under time pressure, sometimes at
3 a.m. in a dim resus bay.

**The one job of every screen.** Get the clinician to a trustworthy number or
decision *fast*, without ambiguity, and let them read it in any lighting.

That brief drives three non-negotiables:

1. **Legibility first.** Contrast and type hierarchy beat decoration. No white text
   on white, no low-contrast gray-on-gray, ever.
2. **Result-forward.** The answer (score, dose, interpretation) is the hero of the
   screen — never buried under inputs.
3. **Calm, not flashy.** Motion and color are used to *direct attention to clinical
   state*, not to entertain.

## 2. Design language

**"Clinical Calm × Modern Precision."** Two references, deliberately combined:

- **UpToDate** — authoritative clinical hierarchy, content-first layout, calm
  neutral palette, strong typographic structure. This governs *hierarchy and tone*.
- **Linear** — crisp near-black dark mode, hairline borders instead of heavy
  shadows, restrained single accent, tight type scale, precise spacing. This
  governs *surface treatment, dark mode, and polish*.

**The signature element.** The *result readout*: a prominent panel with tabular
(monospaced) figures and a colored **severity rail** down the left edge that maps
to clinical state (normal / caution / critical). It's the one thing EMtools is
remembered by, and everything around it stays quiet so it can shout.

**The one risk.** Elevation in dark mode is expressed through *surface tint + a
hairline border* (Linear-style), not drop shadows — so the UI reads as etched
panels of light rather than floating cards. Boldness is spent there and on the
severity rail; the rest is disciplined.

## 3. Color tokens

Accent stays **clinical teal** — it is already the app's identity, and teal reads as
calm/medical rather than alarming (alarm colors are reserved for real clinical
severity). Everything else is a refined neutral system tuned per mode.

### Light mode

| Token | Hex | Use |
|---|---|---|
| `bgBase` | `#F6F8FA` | App / scaffold background (cool off-white, less glare than pure white) |
| `bgSubtle` | `#EEF1F5` | Section wells, input fill, inset areas |
| `surface` | `#FFFFFF` | Cards, sheets, elevated content |
| `surfaceHover` | `#F9FAFB` | Card hover / pressed |
| `border` | `#E4E8EE` | Hairline dividers & card borders |
| `borderStrong` | `#D3D9E0` | Emphasized separators, input outlines |
| `ink` (text primary) | `#0F1729` | Headings & primary text |
| `textSecondary` | `#5B6675` | Supporting text, labels |
| `textTertiary` | `#8B96A5` | Hints, disabled, captions |

### Dark mode (near-black, cool slate — Linear-style)

| Token | Hex | Use |
|---|---|---|
| `bgBase` | `#0B0D12` | App / scaffold background |
| `bgSubtle` | `#12151C` | Section wells, input fill |
| `surface` | `#161A22` | Cards, sheets |
| `surfaceHover` | `#1C212B` | Card hover / raised |
| `border` | `#242A34` | Hairline dividers & card borders |
| `borderStrong` | `#2F3742` | Emphasized separators |
| `ink` (text primary) | `#EDF0F4` | Headings & primary text (soft white — avoids halation) |
| `textSecondary` | `#9AA3B2` | Supporting text |
| `textTertiary` | `#6A7382` | Hints, disabled, captions |

> **Never** use `#FFFFFF` for dark-mode text. Use `ink` (`#EDF0F4`) to prevent glare
> in dark rooms.

### Accent — clinical teal

| Token | Light | Dark | Use |
|---|---|---|---|
| `primary` | `#0D9488` | `#2DD4BF` | Primary actions, active state, brand (dark uses a brighter teal for contrast on near-black) |
| `primaryHover` | `#0F766E` | `#5EEAD4` | Hover / pressed |
| `onPrimary` | `#FFFFFF` | `#04211E` | Text/icon on a filled primary surface |
| `primarySoft` | `primary @ 10%` | `primary @ 16%` | Tinted icon chips, selected pills |

### Clinical status (semantic — reserve for real medical meaning)

| Token | Light | Dark |
|---|---|---|
| `success` / normal | `#16A34A` | `#22C55E` |
| `warning` / caution | `#D97706` | `#F59E0B` |
| `error` / critical | `#DC2626` | `#EF4444` |
| `info` | `#2563EB` | `#3B82F6` |

Status colors are **functional only** — never use red/green/amber as decoration.
On tinted backgrounds use the color at 12–16% alpha with the solid color for text.

## 4. Typography

**Family.** `Inter` for all UI (via `google_fonts`). Numeric clinical readouts use
**tabular / monospaced figures** (`JetBrains Mono`, fallback Roboto Mono) so digits
align and don't jitter as values change.

| Role | Size / Weight | Tracking | Notes |
|---|---|---|---|
| Display | 30 / 700 | -0.5 | Dashboard title only |
| H1 | 24 / 700 | -0.3 | Screen title |
| H2 | 20 / 600 | -0.2 | Section header |
| H3 | 17 / 600 | 0 | Card title |
| Title | 15 / 600 | 0 | List item / control label |
| Body | 15 / 400 | 0 | Reading text |
| Body-sm | 14 / 400 | 0 | Secondary text |
| Label | 13 / 500 | 0.1 | Field labels, chips |
| Caption | 11 / 500 | 0.2 | Micro-labels, stat captions |
| **Readout** | 28–40 / 700, **tabular** | 0 | The result number (severity-colored) |

Rules: sentence case for all labels and buttons; one H1 per screen; never skip a
level to fake emphasis (use weight/color, not size jumps).

## 5. Spacing, radius, elevation

**Spacing scale (4-base):** `4, 8, 12, 16, 20, 24, 32, 48`. Screen gutter = 20.
Card padding = 16–20. Section gap = 24.

**Radius:** card `14`, control/input `10`, chip `8`, pill `999`, icon-chip `10`.

**Elevation:**
- Light mode: flat surfaces, `border` hairline; one soft shadow token
  (`0 1 2 rgba(16,24,40,.06)`) for popovers/menus only.
- Dark mode: **no drop shadows.** Elevation = step up the surface ladder
  (`bgBase → surface → surfaceHover`) + hairline `border`.

## 6. Motion

Purposeful and subtle. Durations: hover/press `150ms`, enter/reveal `200ms`,
page transitions use the platform Cupertino builder already configured.
Curves: `easeOut` for enter, `easeInOut` for state. The only looping animation
allowed is the resus-timer `PulsingDot` (functional liveness). **Respect
`prefers-reduced-motion`** — gate any non-essential motion.

## 7. Components

- **Card** — `surface` bg, `border` hairline, radius 14, padding 16–20, no shadow.
  Optional tinted icon-chip (`primarySoft`, radius 10) top-left.
- **Section header** — 4px `primary` accent rail + H2 label. (Already the app pattern.)
- **Result readout** — `surface` card, left **severity rail** (4px, status color),
  tabular readout number in status color, caption label above, interpretation below.
- **Status badge** — status color @ 12% bg + @ 30% border + solid text, radius 8.
- **Input** — `bgSubtle` fill, `borderStrong` outline, radius 10, `primary` focus ring.
- **Primary button** — filled `primary`, `onPrimary` text, radius 10, no elevation.
- **Nav (rail/bottom)** — `surface` bg, active item = `primarySoft` pill + `primary`
  icon/label; inactive = `textSecondary`.

## 8. Accessibility floor (non-negotiable)

- Body/label text ≥ 4.5:1 contrast against its background in **both** modes.
- Large text / icons ≥ 3:1.
- Never encode clinical meaning by color alone — pair with a label or icon.
- Minimum touch target 44×44.
- Visible keyboard focus; reduced motion respected.

## 9. How to apply (for contributors & agents)

1. **Never hardcode a raw color** in a screen. Use `AppColors` adaptive helpers
   (`AppColors.getX(isDark)`) or theme roles. Any literal `Colors.white` /
   `Color(0xFF…)` background is a bug unless guarded by `isDark`.
2. Pull `isDark` once per `build`: `final isDark = Theme.of(context).brightness == Brightness.dark;`
3. Prefer `Theme.of(context).colorScheme` / `textTheme` for framework widgets.
4. When adding a screen, reuse the components in §7 before inventing new ones.
5. Verify contrast in both modes before shipping.
