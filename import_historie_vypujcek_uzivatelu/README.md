# Import historie uživatelů

Doplnění a přiřazení historie uživatelů. V případě, že jsou přemigrováni uživatelé. Pole **userid** by po úspěšné migraci mělo obsahovat staré ID z Alephu. Za pomocí tohoto pole pak budeme schopni přiřadit správná historická data ke správnému uživateli.

### 1. vytvoření pomocné tabulky

Za pomocí SQL dotazu ve struktuře KOHY vytvoříme pomocnou tabulku -> [create_tmp_historie_uzivatelu.sql](https://github.com/open-source-knihovna/aleph2koha/blob/master/import_historie_vypujcek_uzivatelu/create_tmp_historie_uzivatelu.sql).

### 2. Vyexportování dat z ALEPHu

Na databázi s ALEPHem pustíme SQL dotaz -> [aleph_export_data_do_tmp_historie_uzivatelu.sql
](https://github.com/open-source-knihovna/aleph2koha/blob/master/import_historie_vypujcek_uzivatelu/aleph_export_data_do_tmp_historie_uzivatelu.sql) . 
Vybraná data ukládám ve formátu CSV. Nastavení pro export CSV mám tato:
[CSV - nastavení](https://github.com/open-source-knihovna/aleph2koha/blob/master/import_historie_vypujcek_uzivatelu/nastaveni_exportu.jpg).

Pomocí tohoto příkazu vyexportujeme data ve struktuře pro tabulku, kterou jsme si vytvořili v části 1. Pokud jste pojmenovali exportovaný soubor -> export_historie_uzivatelu_z_alephu.csv, pak budou pro vás platit i následující příkazy.

### 3. import exportovaných dat do KOHY

Soubor s daty nahrajeme na server s KOHOu do adresáře /tmp/ a spustím příkaz **mysql** na serveru.

```bash
root@koha:~# mysql
```

```sql
use koha_koha; // (moje DB)
```

```sql
LOAD DATA INFILE '/tmp/export_historie_uzivatelu_z_alephu.csv'
INTO TABLE tmp_historie_uzivatelu
CHARACTER SET UTF8
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
(borrowernumber,
z30_barcode,
date_due,
branchcode,
returndate,
lastreneweddate,
renewals,
auto_renew,
auto_renew_error,
timestamp,
issuedate,onsite_checkout,note,notedate)
SET tmp_historie_uzivatelu_id = NULL;
```

### 4. Kontrola dat v tabulce tmp_historie_uzivatelu

O tom, že přechozí bod dopadl úspěšně se můžeme přesvědčit za pomocí SQL dotazu:

```sql
select count(*)
from tmp_historie_uzivatelu,borrowers,items 
where tmp_historie_uzivatelu.borrowernumber = borrowers.userid 
and items.barcode = tmp_historie_uzivatelu.z30_barcode;
```

Případně hodně podrobně. Doporučuji si upravit dotaz a zobrazit si data pouze pro jednoho uživatele.

```sql
select 
tmp_historie_uzivatelu.borrowernumber,
borrowers.borrowernumber,
items.barcode,
items.itemnumber,
tmp_historie_uzivatelu.z30_barcode,
tmp_historie_uzivatelu.date_due,
tmp_historie_uzivatelu.branchcode,
tmp_historie_uzivatelu.returndate,
tmp_historie_uzivatelu.lastreneweddate,
tmp_historie_uzivatelu.renewals,
tmp_historie_uzivatelu.auto_renew,
tmp_historie_uzivatelu.auto_renew_error,
tmp_historie_uzivatelu.timestamp,
tmp_historie_uzivatelu.issuedate,
tmp_historie_uzivatelu.onsite_checkout,
tmp_historie_uzivatelu.note,
tmp_historie_uzivatelu.notedate
from
tmp_historie_uzivatelu,
borrowers,
items
where 
tmp_historie_uzivatelu.borrowernumber = borrowers.userid 
and items.barcode = tmp_historie_uzivatelu.z30_barcode;
```
Zkontrolujte výsledek dotazu a porovnejte ho s aktuálním stavem. 

### 5. Naplnění tabulky old_issues za použití tmp tabulky

Spuštěním následujícího SQL dotazu dojde k migraci dat do tabulky old_issues. Po kontrole dat je možné tabulku **tmp_historie_uzivatelu** smazat.

```sql
INSERT INTO old_issues
select
null, 
borrowers.borrowernumber,
items.itemnumber,
tmp_historie_uzivatelu.date_due,
tmp_historie_uzivatelu.branchcode,
tmp_historie_uzivatelu.returndate,
tmp_historie_uzivatelu.lastreneweddate,
tmp_historie_uzivatelu.renewals,
tmp_historie_uzivatelu.auto_renew,
tmp_historie_uzivatelu.auto_renew_error,
tmp_historie_uzivatelu.timestamp,
tmp_historie_uzivatelu.issuedate,
tmp_historie_uzivatelu.onsite_checkout,
tmp_historie_uzivatelu.note,
tmp_historie_uzivatelu.notedate
from
tmp_historie_uzivatelu, borrowers, items
where 
tmp_historie_uzivatelu.borrowernumber = borrowers.userid
and items.barcode = tmp_historie_uzivatelu.z30_barcode;
```sql