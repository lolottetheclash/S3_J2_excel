
#page de référence 
$page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))  

def nom_mairie
# stocke les noms de mairie dans l'array array_mairie
	array_mairie = []
	# va chercher tous les liens qui ont la classe lientxt
	$page.css('a.lientxt').each do |nom|
	#prend le nom de chaque lien et le stocke dans l'array array_mairie
	puts nom = nom.text
	array_mairie.push(nom)
	end
return array_mairie
end



def mairies
	
# stocke les liens des mairies dans l'array array_final
	array_final = []
	array_mail = []
	array_liens = $page.xpath('//a')
	#stocke chaque lien dans un array_liens
	array_liens.each do |array_lien|
		#stocke uniquement les liens qui nous intéressent( qui contiennent la classe lientxt, pas tous les liens de la page)
		if array_lien['class'] == "lientxt"
			#on stocke le lien dans la variable nom
	  	 	nom = array_lien['href']
	  	 	# on prend la partie du lien qui nous intéresse: on enlève le "." du début qui fausserait a future adresse
	  	 	nom = nom[1..nom.length]
	  	 	#on initialise une nouvelle page de référence qui prendra la valeur de chaque lien "nom"
	   	 	page2 = Nokogiri::HTML(open("http://annuaire-des-mairies.com#{nom}"))
			#on va sur chaque élément "mail" qu'on va stocker dans l'array_mail
			page2.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').each do |mail|
				 puts mail = mail.text 
				array_mail.push(mail)
			end
		
		end
	end
	#on convertit les deux array en 1 hash contenant les noms des mairies et leur mail associé
	return la_totale = nom_mairie.zip(array_mail).to_h
end

puts mairies
