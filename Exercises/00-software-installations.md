# Software installations

Before our first class on Monday, please do the following steps.  
If you run into problems, just send me an [e-mail](mailto:antti.karkman@helsinki.fi) and I will help you out.  

## Download and install the following software to your own computer

* [Bandage](https://rrwick.github.io/Bandage/)
* [IGV](https://software.broadinstitute.org/software/igv/download)

## Windows users ONLY if you want to use an SSH connection from your laptop

Follow the instructions and install OpenSSH if you do not have it already

* [OpenSSH](https://learn.microsoft.com/en-us/windows-server/administration/openssh/openssh_install_firstuse?tabs=gui#install-openssh-for-windows)

__Please let me know if you would like to use a laptop from the university.__  
We have Linux laptops that can be borrowed.


## List of tools

`export PATH="/projappl/$PROJECT/qc_assembly_tykky/bin:$PATH"`
NANOPLOT/NANOQC
CHOPPER
FLYE
QUAST

`module load cutadapt/5.1.0`
cutadapt

`export PATH="/projappl/$PROJECT/quast_tykky/bin:$PATH"`
quast


`module load bio-apps/v202603`
`module load py-gtdbtk/2.7.2`
echo $GTDBTK_DATA_PATH
GTDBTK +db


`module load bio-apps/v202603`
`module load spades/4.3.0`
spades.py


`module load bio-apps`
`module load py-bakta`
bakta

`module load bio-apps`
`module load checkm2`
checkm2


`module load bio-apps`
`module load py-gtdbtk`
gtdbtk


`export PATH="/projappl/project_2020859/pangenome_tykky/bin:$PATH"`
abricate
