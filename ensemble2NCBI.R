# DATASETS

# Homo_sapiens: hsapiens_gene_ensembl
# Drosophila_melanogaster: dmelanogaster_gene_ensembl
# Mus_musculus: mmusculus_gene_ensembl
# Caenorhabditis_elegans: celegans_gene_ensembl
# Danio_rerio: drerio_gene_ensembl




### ESTRAGGO LE PROTEINE
# Leggi il file di testo
nome_organismo = "Xenopus_tropicalis"
root = "D:\\file input\\Networks\\"
estensione = ".txt"
fornitore = "_NCBI"
data <- read.table(paste(root, nome_organismo, estensione, sep = ""), header = FALSE)

# Estrai le prime due colonne
df <- data[, 1:2]

# Trasforma i valori delle prime due colonne in un vettore
valori <- unlist(df)

# Rimuovi gli elementi duplicati
valori_senza_duplicati <- unique(valori)


# VA
library(biomaRt)
#datasets <- listDatasets(ensembl)         # per conoscere tutte le ensembl annotations esistenti
mart <- useMart(biomart = "ensembl", dataset = "xtropicalis_gene_ensembl")
results <- getBM(attributes = c("ensembl_peptide_id",
                                "entrezgene_id"),
                 filters = "ensembl_peptide_id",
                 values = valori_senza_duplicati,
                 mart = mart)

results
write.table(results, file = paste(nome_organismo, fornitore, estensione, sep = ""), sep = "\t", quote = FALSE, row.names = FALSE)
