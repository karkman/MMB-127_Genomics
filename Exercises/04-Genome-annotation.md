# Day 5: Genome annotation

## Connecting to Roihu

See the instructions [here](01-UNIX-and-CSC.md#connecting-to-roihu).

## Navigating to the  right folder

First things first.  
When you connect to Puhti, you will be in your home folder. You have all your course data in your own folder under the course projects `/scratch` folder. So by using commands like `csc-workspaces`, `cd`, `ls` and `pwd` make sure you are in the right folder before you start working.  

When your ready and can see your own course folder, you can move on.  

## Annotating the genome using Bakta

First we will annotate our genome using a program called [Bakta](https://github.com/oschwengers/bakta). Among other things, Bakta uses a program called [Prodigal](https://github.com/hyattpd/Prodigal) to find genes and then annotates them using several tools.

Let's start by connecting to the interactive partition. Now we will need a little bit more memory than what we get as default, so we need to specify that (and let's also ask for some more CPUs):

```bash
sinteractive --account $PROJECT --cores 4
```

It also needs its own database files and that they can be found from the `Databases` folder.  
We can also add some additional data about the strain to guide the annotation. So before running the annotation, we need to fill in some data or leave some options out.  

First load bakta module.  

```bash
module load bio-apps
module load py-bakta
```

Then have a look a thhe bakta options with `bakta --help`.  
Then run the annotation with the following command. Make sure to fill in the strain name, genus and locus tag.

```bash
bakta \
      flye_out/assembly.fasta \
      --prefix # our strain name \
      --genus # type here \
      --locus # your strain name \
      --threads 4 \
      --output bakta
```

Take a look inside the output folder using `ls`. To understand what are these files that Bakta has created, take a look [here](https://github.com/oschwengers/bakta#output).

Now take a look at the file ending in `.txt` file using `less`. How many protein-coding genes (a.k.a coding sequences, CDSs) were found? And how many rRNA genes/fragments?  
Then open the file ending in `.tsv`. Look for the 16S rRNA gene from the annotations. Can you locate it from the assembly? We will need this information later today.  

## Extracting KEGG annotations from Bakta output

Bakta also gives the KEGG IDs for different metabolic enzymes in our genome. To reconstruct metabolic pathways based on these annotations, we need to extract them from one the annotation files.  
Navigate to the Bakta output folder and run the following command:  

```bash
grep -o "KEGG:K....." *.gff3 | tr ":" "\t" > kegg_ids.txt 
```

Investigate the file `kegg_ids.txt` using `less`.  
These are known as KO identifiers and is how we link genes to metabolic pathways in the KEGG database.  
This will allow us to put the gene annotations in the context of metabolic pathways.

## Visualising the annotations

We will use `IGV` to visualise the annotations and to extract genes for more exact taxonomic annotation.  
For this you need to download the `.fna` and `.gff3` files from bakta annotations folder to your own computer.  
We will go thru the steps in `IGV` together.  

In case you don't have `IGV` on your own computer, you can use [Proksee](https://proksee.ca/). For that you will need the Genbank file (`.gbff` from Bakta).  

## Genome completeness estimation

The completeness of a genome can be estimated using [CheckM2](https://github.com/chklovski/CheckM2). CheckM2 uses a machine learning model o predict the compeleteness and contamination of a genome. The tools was developed for metagenome-assembled genomes, so it also predicts contamination. Contamination is not such a big problem for us as we work with isolate genomes.  

So first go to the right folder and allocate resources from a computing node.  

```bash
cd /scratch/$PROJECT/$USER/MMB-127_Genomics
sinteractive --account $PROJECT --cores 12
```

Set an environmental variable pointing to the CheckM2 database. Make sure you have asseigned the correct project number to the `$PROJECT` variable.  

```bash
module load bio-apps
module load checkm2
```

Then run CheckM2 on your own genome.  

```bash
checkm2 predict \
      --output-directory CheckM2_out \
      --lowmem \
      --threads $SLURM_CPUS_PER_TASK \
      --extension .fasta \
      --tmpdir $TMPDIR \
      --input # your assembly output folder
```

Open the output folder of CheckM2 and find a file called `quality_report.tsv`.  

## Taxonomic annotation

The taxonomic annotation of genomes can be done with [GTDB-Tk](https://ecogenomics.github.io/GTDBTk/index.html) against the Genome Taxonomy Database ([GTDB](https://gtdb.ecogenomic.org/)).  

GTDB-Tk and its database are available in Roihu, so we can just load the module.  

```bash
module load bio-apps
module load py-gtdbtk
```

Then we can run the taxonomic annotation with GTDB-Tk.  

```bash
gtdbtk classify_wf \
      --out_dir GTDBTK_out \
      --extension .fasta \
      --scratch_dir $TMPDIR \
      --tmpdir $TMPDIR \
      --skip_ani_screen \
      --min_perc_aa 0 \
      --pplacer_cpus 1 \
      --cpus $SLURM_CPUS_PER_TASK \
      --genome_dir # the assembly output folder 
```

Open the output folder of GTDB-Tk and find a file called `gtdbtk.bac120.summary.tsv`.  

Two most important questions from the above steps:

* How complete was the genome you obtained from the assembly based on CheckM2?  
* What was the taxonomic annotation of your genome based on GTDB-Tk?  

## Resistance gene annotation with abricate

To annotate resistance or virulence genes we can use [abricate](https://github.com/tseemann/abricate). Abricate comes with a bunch of pre-installed databases, but additional database can also be installed. For biocide and metal resistance genes, [BacMet database](http://bacmet.biomedicine.gu.se/) has been downloaded to our projects database folder.  
You can check which databases are available with:

```bash
/projappl/$PROJECT/abricate/bin/abricate --list
```

And check how abricate works with:

```bash
/projappl/$PROJECT/abricate/bin/abricate --help
```

If you want to use the bacmet database, specify database directory with `--datadir /projappl/$PROJECT/Databases/` and the database name with `--db bacmet`.
