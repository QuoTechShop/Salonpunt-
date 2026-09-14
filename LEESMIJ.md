# Deze map is de website

Alles wat hier staat, staat straks op je subdomein. Niets meer, niets minder.

- `index.html` — de demosite met de drie sjablonen
- `software/index.html` — de backend (de achterkant)
- `img/` — de foto's
- `favicon.svg`, `og.jpg` — pictogram en deelplaatje

## Eenmalig instellen

### 1. Van deze map een repository maken

GitHub Desktop → *File* → *Add local repository* → kies deze map → hij vraagt of
hij er een repository van moet maken → ja. Dan *Publish repository*.

### 2. Een token maken voor Plesk

Plesk kan niet met je GitHub-wachtwoord inloggen; GitHub accepteert dat sinds
2021 niet meer voor git. Je hebt een token nodig:

1. github.com → je profielfoto → **Settings**
2. onderaan links **Developer settings**
3. **Personal access tokens** → **Fine-grained tokens** → *Generate new token*
4. Naam: `plesk-salonpunt`. Vervaldatum: kies bewust — als hij verloopt, stopt
   het uitrollen en moet je hier een nieuwe maken.
5. **Repository access** → *Only select repositories* → kies je repo
6. **Permissions** → *Repository permissions* → **Contents** → **Read-only**
7. *Generate token* → kopieer hem meteen, je ziet hem maar één keer
   (hij begint met `github_pat_`)

Die token hoort alleen in Plesk thuis. Deel hem verder met niemand.

### 3. Plesk koppelen

Plesk → je subdomein → **Git** → *Add Repository* → **Remote repository**:

| Veld | Wat erin moet |
|---|---|
| Repository URL | de HTTPS-URL van je repo, gekopieerd via de groene **Code**-knop op GitHub |
| Username | je GitHub-**gebruikersnaam** (niet je e-mailadres) |
| Password | de token uit stap 2 |
| Deployment mode | Automatic |
| Server path | **de document root van het subdomein** — zie hieronder |

**Let op de server path.** Kijk eerst onder *Websites & Domains* → je subdomein
→ *Hosting settings* wat de document root is. Staat daar `.../httpdocs`, kies
dan die map — anders komen de bestanden één map boven de website terecht en
blijft je subdomein leeg.

### 4. Webhook

Plesk toont na het aanmaken een **webhook URL**. Kopieer die →
GitHub → je repo → *Settings* → *Webhooks* → *Add webhook* → plakken,
content type `application/json` → *Add webhook*.

## Elke keer daarna

Claude schrijft de gewijzigde bestanden in deze map. Jij:

1. GitHub Desktop openen — de wijziging staat er al.
2. **Commit to main**.
3. **Push origin**.

Binnen een paar seconden staat het live.

## Als het niet werkt

| Wat je ziet | Wat het is |
|---|---|
| `could not read Username for 'https://github.com'` | Plesk kreeg geen werkende inloggegevens. Token in plaats van wachtwoord, gebruikersnaam in plaats van e-mail. |
| `repository not found` | De URL klopt niet. Haal hem op via de groene **Code**-knop op GitHub. |
| Deploy lukt, maar de site blijft leeg | Verkeerde server path. Zie stap 3. |
| Werkte eerst, nu niet meer | Token verlopen. Maak een nieuwe en werk hem bij in Plesk. |

Handmatig uitrollen kan altijd: Plesk → Git → *Pull updates*.

Wil je het jezelf makkelijker maken: zet de repo op **public**. Dan zijn er geen
inloggegevens nodig. Wat erin staat is toch al openbaar — het is precies wat
bezoekers van je subdomein kunnen downloaden.
