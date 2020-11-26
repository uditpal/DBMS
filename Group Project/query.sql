
-- query 1
select * 
    from  T8_VEHICLE v inner join T8_CUSTOMER c on v.Cust_id=c.Cust_id  
    where c.Cust_id in ( 
		select x.Cust_id 
        from T8_CLAIM x 
        where x.Claim_Status = 'Pending');
        
        
 -- query 2
 select * 
    from T8_CUSTOMER c1 
    where c1.Cust_id in 
    (select p.Cust_id from T8_PREMIUM_PAYMENT p 
    where (p.Premium_Payment_Amount > (select sum(CAST(Cust_Id as unsigned)) from T8_CUSTOMER)));
 
 
 
 
 -- query 3
 select * 
    from T8_INSURANCE_COMPANY 
    where Company_Name in (
		select T8_OFFICE.Company_Name 
		from T8_OFFICE
		group by Company_Name 
		having count(distinct (Address))>1 and Company_Name in (
			select T8_DEPARTMENT.Company_Name
			from T8_PRODUCT , T8_DEPARTMENT
            where T8_DEPARTMENT.Company_Name = T8_PRODUCT.Company_Name 
			group by T8_DEPARTMENT.Company_Name 
			having count(distinct (Product_Number)) > count(distinct (Department_Name))));   
			
			
-- query 4
select *
    from T8_CUSTOMER 
    where Cust_id in (
		select Cust_id 
		from T8_INCIDENT_REPORT 
        where Cust_id in (
			select Cust_id 
            from T8_VEHICLE 
            group by Cust_id 
            having count(Cust_id) > 1) and Cust_id not in (select Cust_id from T8_PREMIUM_PAYMENT));
            
                
		
			
-- query 5
select *
    from T8_VEHICLE as v, T8_PREMIUM_PAYMENT as p where v.Cust_id = p.Cust_id and p.Premium_Payment_Amount > v.Vehicle_Number;	
    
    
    
-- query 6
select Cust_Id, Cust_FName, Cust_LName, Cust_DOB, Cust_Gender, Cust_Address, Cust_MOB_Number, Cust_Email, Cust_Passport_Number, Cust_Marital_Status, Cust_PPS_Number
    from T8_CUSTOMER
    where Cust_id in (
		select distinct (cl.Cust_id)
		from T8_CLAIM as cl, T8_CLAIM_SETTLEMENT as cs, T8_COVERAGE as co 
        where cl.Claim_Amount > cs.Claim_Settlement_id + cs.Vehicle_id + cl.Claim_id + cl.Cust_id and cl.Claim_Amount < Coverage_Amount ); 
