# Day 9: Wrap up exercises

* How many genes were annotated, and how many of them were functionally annotated?
* What percentage of genes received a KEGG annotation?

Example

```bash
kegg=$(grep -c "KEGG" bakta/bakta_genome.tsv)
total=$(grep -c "cds" bakta/bakta_genome.tsv)

echo "Genes with KEGG: $kegg"
echo "Total genes: $total"
echo "Percentage: $((kegg * 100 / total))%"
```
