select 
trim(z36h.z36h_ID) as BORROWERNUMBER, 
trim(z30_barcode) as z30_barcode,
case when z36h_due_date=0 then '' else substr(z36h_due_date,0,4) || '-' || substr(z36h_due_date,5,2) || '-' || substr(z36h_due_date,7,2) end as DATE_DUE, 
trim(z36h_sub_library) AS BRANCHCODE,  
case when z36h_returned_date=0 then '' else substr(z36h_returned_date,0,4) || '-' || substr(z36h_returned_date,5,2) || '-' || substr(z36h_returned_date,7,2) end as returndate, 
case when z36h_last_renew_date=0 then '' else substr(z36h_last_renew_date,0,4) || '-' || substr(z36h_last_renew_date,5,2) || '-' || substr(z36h_last_renew_date,7,2) end  as lastreneweddate, 
z36h_no_renewal as renewals, 
'' as auto_renew, 
'' as auto_renew_error,
case when z36h_time=0 then '' else substr(z36h_time,0,4) || '-' || substr(z36h_time,5,2) || '-' || substr(z36h_time,7,2) || ' ' || substr(z36h_time,9,2) || ':' || substr(z36h_time,11,2) || ':' || substr(z36h_time,13,2) end as timestamp, 
case when z36h_loan_date=0 then '' else substr(z36h_loan_date,0,4) || '-' || substr(z36h_loan_date,5,2) || '-' || substr(z36h_loan_date,7,2)  end as issuedate, 
'0' as onsite_checkout,
'' as note,
'' as notedate
from z36h
left outer join z30 on z36h_rec_key=z30_rec_key
where 
z30_barcode is not null 
;