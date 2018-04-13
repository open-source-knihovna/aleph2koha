select
trim(substr( z308.Z308_REC_KEY,3,15)) cardnumber,
substr(z303.Z303_NAME, 1, instr(Z303_NAME, ' ') - 1) as surname,
substr(Z303_NAME, instr(Z303_NAME, ' ') + 1)    as firstname,
z303.Z303_TITLE as title,
'' as OTHERNAMES,
'' as initials,
'11/225' as streetnumber, -- musí se dodělat lepší parsování
'' as streettype,
'Dr. Machatého' as address,
'Malý Studenec' as address2,
'Liberec' as city, -- musí se dodělat lepší parsování
'' as state,
'35601' as zipcode,
'' as country,
'martin.mikac@gmail.com' as email,
'' as phone,
'' as mobile,
'' as fax,
'' as emailpro,
'' as phonepro,
'' as B_streetnumber,
'' as B_streettype,
'' as B_address,
'' as B_address2,
'' as B_city,
'' as B_state,
'' as B_zipcode,
'' as B_country,
'' as B_email,
'' as B_phone,
'2000-01-01' as dateofbirth,
'HALA' as branchcode,
z305.Z305_BOR_STATUS as categorycode,
case when Z305_REGISTRATION_DATE=0 then '' else substr(Z305_REGISTRATION_DATE,0,4) || '-' || substr(Z305_REGISTRATION_DATE,5,2) || '-' || substr(Z305_REGISTRATION_DATE,7,2) end as dateenrolled,
case when Z305_EXPIRY_DATE=0 then '' else substr(Z305_EXPIRY_DATE,0,4) || '-' || substr(Z305_EXPIRY_DATE,5,2) || '-' || substr(Z305_EXPIRY_DATE,7,2) end as dateexpiry,
'' as date_renewed,
'' as gonenoaddress, --??????????
'' as lost,
'' as debarred,
'' as debarredcomment,
'' as contactname,
'' as contactfirstname,
'' as contacttitle,
'' as guarantorid,
'' as borrowernotes,
'' as relationship,
'' as sex,
'**PASSWORD**' as password,
'' as flags,
'' as userid,
'' as opacnote,
'' as contactnote,
'' as sort1,
'' as sort2,
'' as altcontactfirstname,
'' as altcontactsurname,
'' as altcontactaddress1,
'' as altcontactaddress2,
'' as altcontactaddress3,
'' as altcontactstate,
'' as altcontactzipcode,
'' as altcontactcountry,
'' as altcontactphone,
'' as smsalertnumber,
'' as sms_provider_id,
'' as privacy,
'' as privacy_guarantor_checkouts,
'' as checkprevcheckout,
'' as updated_on,
'' as lastseen,
'' as lang,
'' as login_attempts,
'' as overdrive_auth_token


from z303,
     z304,
     z305,
     z308
     
where 
        z303_rec_key = substr(z305_rec_key,1,12) 
        and z303_rec_key = z308.Z308_ID 
        and z303_rec_key = substr(z304_rec_key, 1,12) 
        and substr(z305_rec_key,1,12) = substr(z304_rec_key,1,12)
        --and z304_email_address = 'martin.mikac@gmail.com'
        and substr(z308.Z308_REC_KEY,1,2) = 01
        --and z305_expiry_date = 20170222
        --and z305.Z305_EXPIRY_DATE < TO_CHAR((sysdate -712), 'YYYYMMDD')
; 