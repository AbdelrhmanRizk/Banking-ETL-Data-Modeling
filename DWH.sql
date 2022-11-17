-----------------Card Dim-------------------
select card_id, type, fulldate
from Card 


-----------------Account Dim-------------------
select acc.account_id, acc.frequency, acc.parseddate, acc.year, acc.month, acc.day 
from Account acc , Card c , Disposition d
Where acc.account_id = d.account_id
and d.disp_id = c.disp_id

-----------------Loan Dim-------------------
select purpose, status, loan_id, location, duration, fulldate
from Loan 

-----------------Customer Dim-------------------
select client_id, sex, age, first, last, address_1
from Client 

-----------------District Dim-------------------
select district_id, city, state_name, region, division
from District

-----------------CRM Reviews Dim-------------------
select RID, Date, Product 
from CRM_Reviews 

-----------------CRM Events Dim-------------------
select e.[Complaint ID], e.[Date sent to company], e.[Date received], e.[Submitted via],
	   e.Product, e.[Sub-product]
from CRM_Event e , CRM_Call_Center cc
Where e.[Complaint ID] = cc.[Complaint ID]

-----------------Call Center Dim-------------------
select [Complaint ID], [Date received], phonefinal, server
from CRM_Call_Center 

-----------------Fact Transaction-------------------
select t.["amount"], t.["trans_id"],  t.["bank"] , t.["operation"],
		t.["fulltime"] , l.loan_id, c.card_id, d.district_id
from [dbo].[Transaction] t, Loan l, Card c, District d, Account a, Disposition dis
where t.["account_id"] = a.account_id
and   d.district_id = a.district_id
and   dis.account_id = a.account_id
and   l.account_id = a.account_id
and   dis.disp_id = c.disp_id


------------------Fact CRM--------------------- 
select e.[Company response to consumer], e.[Timely response?], c.outcome, r.Stars,
	   e.Issue, cl.client_id, r.RID, d.district_id, e.[Complaint ID]
from CRM_Event e, CRM_Call_Center c, CRM_Reviews r, Client cl, District d
where d.district_id = r.district_id
and d.district_id = cl.district_id
and cl.client_id = e.Client_ID
and e.[Complaint ID] = c.[Complaint ID]
