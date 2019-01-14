# DSPJRNPST
Retrieve journal post and convert it.  
AFFICHER LES POSTES DU JOURNAL DE FAÇON INTELLIGIBLE  
DSPJRN est la commande qui permet de voir les postes du journal.   
Et ce que l'on aime, c'est de voir le contenu de l'enregistrement concerné.  
Mais voilà l'enregistrement est placé brut dans une zone de type caractère,  
la plupart du temps illisible s'il y a des champs en Decimal Packed.  
Voici une petite commande qui permet de le rendre lisible : DSPJRNPST.  
Elle se compose des étapes de création d'un membre source DDS  
à partir des caractéristiques du fichier type1 d'une sortie de DSPJRN  
et du source du fichier dont nous voulons les postes du journal.  
Puis la commande DSPJRN récupère les postes qui sont insérés  
dans le fichier constitué précédemment.  
Et pour finir un QUERY(obsolète, c'est une partie à revoir).
