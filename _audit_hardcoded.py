#!/usr/bin/env python3
"""Find hardcoded French UI strings NOT already in AppStrings or LString constructors."""
import re
import os

screen_dir = 'lib/presentation'
hardcoded = []

for root, dirs, files in os.walk(screen_dir):
    for f in files:
        if not f.endswith('.dart'):
            continue
        path = os.path.join(root, f)
        with open(path, 'r', encoding='utf-8') as fh:
            content = fh.read()
        
        # Find single-quoted strings that look like French UI text
        # Pattern: starts with a capital letter or accented letter
        pattern = r"(?<![a-zA-Z])'([A-ZÀ-ÿÉÈÊËÎÏÔÖÙÛÜ][^']{3,80})'"
        for m in re.finditer(pattern, content):
            s = m.group(1)
            # Skip if inside LString constructor
            start = m.start()
            before = content[max(0, start-60):start]
            if 'LString(' in before and before.rfind('LString(') > before.rfind(')'):
                continue
            # Skip if inside import/export
            if content[:start].count("'") % 2 == 0:
                # Skip common non-UI patterns  
                skip = ['dart', 'package', 'import', 'export', 'Icons.', 'Colors.', 'AppStrings.',
                        'EdgeInsets', 'Duration', 'Curves', 'TextStyle', 'FontWeight', 'MainAxisAlignment',
                        'CrossAxisAlignment', 'BorderRadius', 'BoxDecoration', 'BoxShape', 'Alignment',
                        'Material', 'Scaffold', 'AppBar', 'Navigator', 'Theme.of', 'context.',
                        'widget.', 'protocol.', 'calc.', '_calculator.', '_antibiotic.',
                        'Navigator', 'ThemeMode', 'Color', 'Brightness', 'AppColors',
                        'Calculator', 'CalculatorField', 'ScoreInterpretation', 'ProtocolStep',
                        'Protocol', 'CalculatorOption', 'FilteringTextInputFormatter']
                is_skip = any(s.startswith(sk) for sk in skip)
                if not is_skip and not s.startswith('//') and not s.startswith('/*'):
                    hardcoded.append((path, s[:120]))

# Print results grouped by file
current_file = None
for path, s in sorted(hardcoded):
    if path != current_file:
        current_file = path
        print(f"\n=== {path} ===")
    print(f"  '{s}'")
