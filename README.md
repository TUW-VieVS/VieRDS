# short description
VieRDS is a software to simulate raw telescope data for Very Long Baseline Interferometry (VLBI). It uses a YAML input file to create simulated raw telescope data in VDIF format.

# build/usage requirements
Matlab

# installation instructions
Download, installation, and run instructions can be found in the pdf "Informal Documentation" in the folder DOC/

# quickstart

(1) With Matlab Installation from Linux Command Line

set up VLBI simulation scenario in input_val.yaml file (you can find plenty of examples in the EXAMPLES/ folder)

then run, e.g.:
/usr/local/MATLAB/R2020a/bin/matlab -c ~/.matlab/R2020a_licenses/license_jgruber1_338656_R2020a.lic -nodisplay  -r 'vierds input_val.yaml; exit;'

# link to usage examples
Examples can be found in the EXAMPLES\ folder

# link to paper
(submitted to PASP)

# list of developers
Jakob Gruber https://www.vlbi.at/index.php/rushmore_teams/grubsi/

# user support
jakob.franz.gruber@geo.tuwien.ac.at
