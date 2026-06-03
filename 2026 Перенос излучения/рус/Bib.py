import re

CiteList = []
pattern = r"\\cite\{([^}]+)\}"
with open('text.tex', 'r', encoding = 'windows-1251') as file:
	for line in file:
		matches = re.findall(pattern, line)
		for match in matches:
			CiteList.append(match)

AuthorList = []
for cite in CiteList:
	for Author in cite.split(','):
		if Author not in AuthorList:
			AuthorList.append(Author)

# for author in AuthorList:
# 	print(author)

BibList = []
pattern = r"\\bibitem\{([^}]+)\}"
with open('text.tex', 'r', encoding = 'windows-1251') as file:
	for line in file:
		matches = re.findall(pattern, line)
		for match in matches:
			BibList.append(match)

AuthorBibList = []
for Authorbib in BibList:
	if Authorbib not in AuthorBibList:
		AuthorBibList.append(Authorbib)

for i in range(len(AuthorList)):
	if AuthorList[i] != AuthorBibList[i]:
		print(f"Проблема с {AuthorList[i]} и {AuthorBibList[i]}")

# for i in range(len(AuthorList)):
# 	if AuthorList[i] != AuthorBibList[i]:
# 		print(AuthorList[i],AuthorBibList[i])

for i in range(len(AuthorList)):
	print(AuthorList[i],AuthorBibList[i])