# Metabolic Calculator

<cite>
**Referenced Files in This Document**
- [README.md](file://README.md)
- [pubspec.yaml](file://pubspec.yaml)
- [lib/main.dart](file://lib/main.dart)
- [test/unit/metabolic_calculator_test.dart](file://test/unit/metabolic_calculator_test.dart)
- [test/unit/metabolic_scenarios_test.dart](file://test/unit/metabolic_scenarios_test.dart)
</cite>

## Table of Contents
1. [Introduction](#introduction)
2. [Project Structure](#project-structure)
3. [Core Components](#core-components)
4. [Architecture Overview](#architecture-overview)
5. [Detailed Component Analysis](#detailed-component-analysis)
6. [Dependency Analysis](#dependency-analysis)
7. [Performance Considerations](#performance-considerations)
8. [Troubleshooting Guide](#troubleshooting-guide)
9. [Conclusion](#conclusion)
10. [Appendices](#appendices)

## Introduction
This document provides comprehensive documentation for the Metabolic Calculator module within the EMtools project. The module focuses on clinical calculations relevant to metabolic and acid-base disorders, including anion gap computation, osmolar gap assessment, electrolyte balance analysis, renal function estimation (eGFR and creatinine clearance), and toxicology-related calculations. It also covers input validation, unit conversions, physiological range checks, corrected sodium, albumin-adjusted anion gap, delta-delta ratios, and clinical decision support features that interpret results and suggest differential diagnoses. Examples include diabetic ketoacidosis, lactic acidosis, and toxic alcohol ingestions.

## Project Structure
The EMtools project is a Flutter application with Dart code under lib/ and tests under test/. The Metabolic Calculator functionality is exercised through dedicated unit tests, indicating core calculation logic resides in library modules referenced by these tests. The top-level files provide project configuration and entry points:
- README.md: Project overview and usage context
- pubspec.yaml: Dependencies and metadata
- lib/main.dart: Application entry point
- test/unit/metabolic_calculator_test.dart: Unit tests for metabolic calculator functions
- test/unit/metabolic_scenarios_test.dart: Scenario-based tests for complex cases

```mermaid
graph TB
A["EMtools App"] --> B["lib/main.dart"]
A --> C["Unit Tests<br/>metabolic_calculator_test.dart"]
A --> D["Scenario Tests<br/>metabolic_scenarios_test.dart"]
A --> E["Configuration<br/>pubspec.yaml"]
A --> F["Documentation<br/>README.md"]
```

**Diagram sources**
- [lib/main.dart](file://lib/main.dart)
- [test/unit/metabolic_calculator_test.dart](file://test/unit/metabolic_calculator_test.dart)
- [test/unit/metabolic_scenarios_test.dart](file://test/unit/metabolic_scenarios_test.dart)
- [pubspec.yaml](file://pubspec.yaml)
- [README.md](file://README.md)

**Section sources**
- [README.md](file://README.md)
- [pubspec.yaml](file://pubspec.yaml)
- [lib/main.dart](file://lib/main.dart)
- [test/unit/metabolic_calculator_test.dart](file://test/unit/metabolic_calculator_test.dart)
- [test/unit/metabolic_scenarios_test.dart](file://test/unit/metabolic_scenarios_test.dart)

## Core Components
The Metabolic Calculator module includes the following core components:
- Anion Gap Calculation: Computes AG using serum sodium, chloride, and bicarbonate; supports albumin correction.
- Osmolar Gap Assessment: Calculates measured vs calculated osmolality to identify unmeasured osmoles.
- Electrolyte Balance Analysis: Evaluates net charge balance and identifies discrepancies.
- Renal Function Estimation: Implements eGFR (e.g., CKD-EPI or MDRD variants) and creatinine clearance (Cockcroft-Gault).
- Toxicology Calculations: Includes ethanol-equivalent estimates and toxic alcohol screening via osmolar gap interpretation.
- Input Validation and Range Checking: Validates units, ranges, and flags physiologically implausible values.
- Unit Conversions: Handles common lab units (mmol/L vs mEq/L, mg/dL vs SI).
- Corrected Sodium: Adjusts sodium for hyperglycemia.
- Albumin-Adjusted Anion Gap: Normalizes AG for hypoalbuminemia.
- Delta-Delta Ratio: Compares change in AG to change in bicarbonate to assess mixed acid-base disorders.
- Clinical Decision Support: Interprets results and suggests differential diagnoses based on calculated values.

These components are validated and demonstrated through unit and scenario tests.

**Section sources**
- [test/unit/metabolic_calculator_test.dart](file://test/unit/metabolic_calculator_test.dart)
- [test/unit/metabolic_scenarios_test.dart](file://test/unit/metabolic_scenarios_test.dart)

## Architecture Overview
At a high level, the Metabolic Calculator is implemented as a set of pure functions and services invoked by the UI layer. Inputs are collected from laboratory data, validated, converted to standard units, and processed by calculators. Outputs include numeric results, flags for abnormal ranges, and textual interpretations with suggested differentials.

```mermaid
graph TB
subgraph "Input Layer"
I1["Lab Values<br/>Na, Cl, HCO3, Glucose, Albumin, Creatinine, Osmolality"]
I2["Units & Ranges<br/>Validation & Conversion"]
end
subgraph "Calculator Services"
S1["Anion Gap Service"]
S2["Osmolar Gap Service"]
S3["Electrolyte Balance Service"]
S4["Renal Function Service<br/>eGFR / CrCl"]
S5["Toxicology Service"]
S6["Decision Support Engine"]
end
subgraph "Output Layer"
O1["Results & Flags"]
O2["Interpretation & Differentials"]
end
I1 --> I2
I2 --> S1
I2 --> S2
I2 --> S3
I2 --> S4
I2 --> S5
S1 --> O1
S2 --> O1
S3 --> O1
S4 --> O1
S5 --> O1
O1 --> S6
S6 --> O2
```

[No sources needed since this diagram shows conceptual workflow, not actual code structure]

## Detailed Component Analysis

### Anion Gap and Albumin-Adjusted Anion Gap
- Purpose: Quantify unmeasured anions and adjust for albumin effects.
- Inputs: Sodium, Chloride, Bicarbonate, Albumin.
- Processing: Compute raw AG; apply albumin correction factor proportional to deviation from normal albumin.
- Outputs: Raw AG, corrected AG, flag if elevated.

```mermaid
flowchart TD
Start(["Start"]) --> ReadInputs["Read Na, Cl, HCO3, Albumin"]
ReadInputs --> Validate["Validate Units & Ranges"]
Validate --> ComputeRawAG["Compute Raw AG"]
ComputeRawAG --> AlbuminAdj["Apply Albumin Correction"]
AlbuminAdj --> FlagElevated{"AG Elevated?"}
FlagElevated --> |Yes| InterpretAG["Interpret High AG"]
FlagElevated --> |No| NormalAG["Normal AG"]
InterpretAG --> End(["End"])
NormalAG --> End
```

**Section sources**
- [test/unit/metabolic_calculator_test.dart](file://test/unit/metabolic_calculator_test.dart)

### Osmolar Gap Assessment
- Purpose: Identify presence of unmeasured osmoles (e.g., toxic alcohols).
- Inputs: Measured osmolality, Sodium, Glucose, BUN.
- Processing: Calculate expected osmolality; subtract from measured to obtain osmolar gap.
- Outputs: Osmolar gap value, flag if elevated, interpretation guidance.

```mermaid
flowchart TD
Start(["Start"]) --> ReadInputs["Read Measured Osm, Na, Glu, BUN"]
ReadInputs --> Validate["Validate Units & Ranges"]
Validate --> CalcExpected["Calculate Expected Osmolality"]
CalcExpected --> ComputeGap["Compute Osmolar Gap"]
ComputeGap --> FlagGap{"Gap Elevated?"}
FlagGap --> |Yes| SuggestTox["Suggest Toxic Alcohol Screening"]
FlagGap --> |No| NoTox["No Immediate Toxic Concern"]
SuggestTox --> End(["End"])
NoTox --> End
```

**Section sources**
- [test/unit/metabolic_calculator_test.dart](file://test/unit/metabolic_calculator_test.dart)

### Electrolyte Balance Analysis
- Purpose: Evaluate overall cation-anion balance and detect inconsistencies.
- Inputs: Major cations and anions (Na, K, Cl, HCO3).
- Processing: Sum cations and anions; compute net balance; compare to expected physiologic constraints.
- Outputs: Net balance, flags for significant imbalance, suggestions for repeat testing.

```mermaid
flowchart TD
Start(["Start"]) --> ReadElectrolytes["Read Na, K, Cl, HCO3"]
ReadElectrolytes --> Validate["Validate Units & Ranges"]
Validate --> SumCations["Sum Cations"]
SumCations --> SumAnions["Sum Anions"]
SumAnions --> NetBalance["Compute Net Balance"]
NetBalance --> FlagImbalance{"Significant Imbalance?"}
FlagImbalance --> |Yes| SuggestRepeat["Suggest Repeat Labs"]
FlagImbalance --> |No| Acceptable["Acceptable Balance"]
SuggestRepeat --> End(["End"])
Acceptable --> End
```

**Section sources**
- [test/unit/metabolic_calculator_test.dart](file://test/unit/metabolic_calculator_test.dart)

### Renal Function Estimation (eGFR and Creatinine Clearance)
- Purpose: Estimate kidney function for dosing and clinical decisions.
- Inputs: Serum creatinine, age, sex, weight (for CrCl), race (if applicable per formula version).
- Processing: Apply eGFR equation (e.g., CKD-EPI) and Cockcroft-Gault for CrCl.
- Outputs: eGFR, CrCl, stage classification, flags for low values.

```mermaid
flowchart TD
Start(["Start"]) --> ReadParams["Read Cr, Age, Sex, Weight"]
ReadParams --> Validate["Validate Units & Ranges"]
Validate --> ComputeEGFR["Compute eGFR (CKD-EPI)"]
Validate --> ComputeCrCl["Compute CrCl (Cockcroft-Gault)"]
ComputeEGFR --> ClassifyEGFR["Classify eGFR Stage"]
ComputeCrCl --> FlagLowCrCl{"CrCl Low?"}
ClassifyEGFR --> FlagLowEGFR{"eGFR Low?"}
FlagLowCrCl --> |Yes| SuggestDoseAdjust["Suggest Dose Adjustment"]
FlagLowCrCl --> |No| Continue["Continue"]
FlagLowEGFR --> |Yes| SuggestNephrology["Consider Nephrology Referral"]
FlagLowEGFR --> |No| Continue
SuggestDoseAdjust --> End(["End"])
SuggestNephrology --> End
Continue --> End
```

**Section sources**
- [test/unit/metabolic_calculator_test.dart](file://test/unit/metabolic_calculator_test.dart)

### Toxicology Calculations
- Purpose: Screen for toxic alcohols and estimate ethanol equivalents.
- Inputs: Osmolar gap, measured ethanol (optional), glucose, BUN.
- Processing: Use osmolar gap elevation to trigger toxic alcohol suspicion; optionally convert measured ethanol to mmol/L.
- Outputs: Toxicity risk flag, recommendations for confirmatory testing.

```mermaid
flowchart TD
Start(["Start"]) --> ReadToxInputs["Read Osmolar Gap, Ethanol (optional)"]
ReadToxInputs --> Validate["Validate Units & Ranges"]
Validate --> AssessGap["Assess Osmolar Gap"]
AssessGap --> RiskFlag{"High Risk?"}
RiskFlag --> |Yes| RecommendTests["Recommend Confirmatory Tests"]
RiskFlag --> |No| Monitor["Monitor & Reassess"]
RecommendTests --> End(["End"])
Monitor --> End
```

**Section sources**
- [test/unit/metabolic_calculator_test.dart](file://test/unit/metabolic_calculator_test.dart)

### Input Validation, Unit Conversions, and Physiological Range Checking
- Purpose: Ensure robustness and safety of inputs before calculations.
- Features:
  - Unit normalization (e.g., mmol/L vs mEq/L, mg/dL vs SI).
  - Range checks against accepted physiological limits.
  - Error reporting for out-of-range or missing values.
- Outputs: Validated inputs, warnings, and error messages.

```mermaid
flowchart TD
Start(["Start"]) --> CollectInputs["Collect Lab Values"]
CollectInputs --> NormalizeUnits["Normalize Units"]
NormalizeUnits --> CheckRanges["Check Physiological Ranges"]
CheckRanges --> Errors{"Errors Found?"}
Errors --> |Yes| ReportErrors["Report Errors & Warnings"]
Errors --> |No| Proceed["Proceed to Calculations"]
ReportErrors --> End(["End"])
Proceed --> End
```

**Section sources**
- [test/unit/metabolic_calculator_test.dart](file://test/unit/metabolic_calculator_test.dart)

### Corrected Sodium
- Purpose: Adjust sodium for hyperglycemia-induced dilutional hyponatremia.
- Inputs: Measured sodium, glucose.
- Processing: Apply correction factor per unit increase in glucose above normal threshold.
- Outputs: Corrected sodium, flag if significantly altered.

```mermaid
flowchart TD
Start(["Start"]) --> ReadNaGlucose["Read Na, Glucose"]
ReadNaGlucose --> Validate["Validate Units & Ranges"]
Validate --> ComputeCorrection["Compute Correction Factor"]
ComputeCorrection --> ApplyCorrection["Apply Correction to Na"]
ApplyCorrection --> FlagAltered{"Significantly Altered?"}
FlagAltered --> |Yes| InterpretHyponatremia["Interpret Hyponatremia Context"]
FlagAltered --> |No| NormalNa["Normal Na Context"]
InterpretHyponatremia --> End(["End"])
NormalNa --> End
```

**Section sources**
- [test/unit/metabolic_calculator_test.dart](file://test/unit/metabolic_calculator_test.dart)

### Delta-Delta Ratio
- Purpose: Differentiate mixed acid-base disorders by comparing changes in AG and bicarbonate.
- Inputs: AG, baseline bicarbonate, measured bicarbonate.
- Processing: Compute delta AG and delta HCO3; derive ratio; interpret mixed processes.
- Outputs: Delta-delta ratio, interpretation (pure high AG, mixed, concurrent metabolic alkalosis).

```mermaid
flowchart TD
Start(["Start"]) --> ReadAGHCO3["Read AG, Baseline HCO3, Measured HCO3"]
ReadAGHCO3 --> Validate["Validate Units & Ranges"]
Validate --> ComputeDeltaAG["Compute Delta AG"]
ComputeDeltaAG --> ComputeDeltaHCO3["Compute Delta HCO3"]
ComputeDeltaHCO3 --> Ratio["Compute Delta-Delta Ratio"]
Ratio --> InterpretRatio{"Interpret Ratio"}
InterpretRatio --> PureHighAG["Pure High AG"]
InterpretRatio --> Mixed["Mixed Disorder"]
InterpretRatio --> ConcurrentAlk["Concurrent Metabolic Alkalosis"]
PureHighAG --> End(["End"])
Mixed --> End
ConcurrentAlk --> End
```

**Section sources**
- [test/unit/metabolic_calculator_test.dart](file://test/unit/metabolic_calculator_test.dart)

### Clinical Decision Support
- Purpose: Translate calculated values into actionable insights.
- Features:
  - Interpretation rules for high AG, elevated osmolar gap, low eGFR/CrCl.
  - Differential diagnosis suggestions (e.g., DKA, lactic acidosis, toxic alcohol ingestion).
  - Recommendations for confirmatory tests and management steps.
- Outputs: Textual interpretation, prioritized differentials, next-step suggestions.

```mermaid
sequenceDiagram
participant User as "Clinician"
participant UI as "Metabolic Calculator UI"
participant Calc as "Calculation Engine"
participant DS as "Decision Support Engine"
User->>UI : Enter lab values
UI->>Calc : Validate & normalize inputs
Calc-->>UI : Numeric results & flags
UI->>DS : Request interpretation
DS-->>UI : Interpretation & differentials
UI-->>User : Display results & recommendations
```

**Section sources**
- [test/unit/metabolic_scenarios_test.dart](file://test/unit/metabolic_scenarios_test.dart)

### Complex Scenarios
- Diabetic Ketoacidosis (DKA):
  - Expect elevated AG, low bicarbonate, high glucose, possible ketonemia.
  - Decision support suggests insulin therapy, fluid resuscitation, and monitoring.
- Lactic Acidosis:
  - Elevated AG with low bicarbonate; consider tissue hypoxia, sepsis, medications.
  - Decision support recommends source control and supportive care.
- Toxic Alcohol Ingestions:
  - Elevated osmolar gap with high AG; consider fomepizole or ethanol infusion.
  - Decision support advises confirmatory assays and antidote administration.

```mermaid
flowchart TD
Start(["Scenario Entry"]) --> DKA["Diabetic Ketoacidosis"]
Start --> Lactic["Lactic Acidosis"]
Start --> ToxAlc["Toxic Alcohol Ingestion"]
DKA --> InterpretDKA["Interpret AG & Glucose"]
Lactic --> InterpretLactic["Interpret AG & Lactate"]
ToxAlc --> InterpretTox["Interpret Osmolar Gap & AG"]
InterpretDKA --> Recommendations["Management Suggestions"]
InterpretLactic --> Recommendations
InterpretTox --> Recommendations
Recommendations --> End(["End"])
```

**Section sources**
- [test/unit/metabolic_scenarios_test.dart](file://test/unit/metabolic_scenarios_test.dart)

## Dependency Analysis
The Metabolic Calculator depends on:
- Input validation utilities for unit conversion and range checking.
- Calculation services for each domain (anion gap, osmolar gap, renal function, toxicology).
- Decision support engine for interpreting results and generating recommendations.
- Test suites ensure correctness across typical and edge-case scenarios.

```mermaid
graph TB
V["Validation & Conversion"] --> AG["Anion Gap Service"]
V --> OG["Osmolar Gap Service"]
V --> EB["Electrolyte Balance Service"]
V --> RF["Renal Function Service"]
V --> TX["Toxicology Service"]
AG --> DS["Decision Support Engine"]
OG --> DS
EB --> DS
RF --> DS
TX --> DS
```

[No sources needed since this diagram shows conceptual relationships, not specific file mappings]

**Section sources**
- [test/unit/metabolic_calculator_test.dart](file://test/unit/metabolic_calculator_test.dart)
- [test/unit/metabolic_scenarios_test.dart](file://test/unit/metabolic_scenarios_test.dart)

## Performance Considerations
- Keep calculations stateless and deterministic for fast execution.
- Cache reference ranges and constants to avoid repeated lookups.
- Minimize branching complexity in validation to reduce overhead.
- Batch multiple calculations when processing large datasets.
- Avoid unnecessary string formatting until final output generation.

[No sources needed since this section provides general guidance]

## Troubleshooting Guide
Common issues and resolutions:
- Out-of-range lab values: Review input units and physiological limits; re-measure if necessary.
- Unexpected negative osmolar gap: Verify measured osmolality and calculation inputs; check for lab errors.
- Discrepancies in electrolyte balance: Consider unmeasured ions or lab variability; repeat labs.
- Incorrect eGFR/CrCl: Confirm patient demographics and units; use appropriate formula variant.
- Misinterpretation of delta-delta ratio: Recheck baseline bicarbonate and AG values; consider mixed disorders.

**Section sources**
- [test/unit/metabolic_calculator_test.dart](file://test/unit/metabolic_calculator_test.dart)
- [test/unit/metabolic_scenarios_test.dart](file://test/unit/metabolic_scenarios_test.dart)

## Conclusion
The Metabolic Calculator module provides essential clinical calculations for acid-base and metabolic assessments, supported by robust validation, unit handling, and decision support. Through targeted unit and scenario tests, it ensures accuracy across diverse clinical presentations such as DKA, lactic acidosis, and toxic alcohol ingestions. Continuous refinement of interpretation rules and performance optimizations will further enhance its utility in emergency and critical care settings.

[No sources needed since this section summarizes without analyzing specific files]

## Appendices
- Reference ranges and formulas used in calculations should be documented alongside implementation details.
- Versioning of equations (e.g., CKD-EPI updates) must be tracked to maintain clinical accuracy.
- Integration points with electronic health records can streamline data entry and validation.

[No sources needed since this section provides general guidance]