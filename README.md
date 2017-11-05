# SFDX HEDA Seed Project

## Usage

### New Project
    # clone seed project
    git clone https://github.com/gbutt/sfdx-heda-seed-project my-heda-project
    cd my-heda-project

    # create scratch org with HEDA
    sh create-new-scratch-org.sh

    # open new scratch org
    sfdx force:org:open


### New Scratch Org
    # remove old scratch org
    sfdx force:org:delete -u hedaScratch

    # create scratch org with HEDA
    sh create-new-scratch-org.sh

    # deploy code
    sfdx force:source:push

    # run tests, etc.