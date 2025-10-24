create database dhiksha_bank;
use dhiksha_bank;

create table branch(
branch_name varchar(30),
branch_city varchar(25),
assets int,
PRIMARY KEY (branch_name)
);

create table bankAccount(
accno int,
branch_name varchar(30),
balance int,
PRIMARY KEY(accno),
foreign key (branch_name) references branch(branch_name)
);

create table bankcustomer(
customername varchar(20),
customer_street varchar(30),
customerCity varchar (35),
PRIMARY KEY(customername)
);

select * from bankcustomer;

create table Depositer(
customername varchar(20),
accno int,
PRIMARY KEY(customername,accno),
foreign key (accno) references bankAccount(accno),
foreign key (customername) references bankcustomer(customername)
);

select * from depositer;

create table Loan(
Loan_number int,
branch_name varchar(30),
Amount int,
PRIMARY KEY(Loan_number),
foreign key (branch_name) references branch(branch_name)
);

select * from loan;

insert into branch values("SBI_Chamrajpet","Bangalore",50000);
insert into branch values("SBI_ResidencyRoad","Bangalore",10000);
insert into branch values("SBI_ShivajiRoad","Bombay",20000);
insert into branch values("SBI_ParlimentRoad","Delhi",10000);
insert into branch values("SBI_Jantarmantar","Delhi",20000);

insert into BankAccount values(1,"SBI_Chamrajpet",2000);
insert into BankAccount values(2,"SBI_ResidencyRoad",5000);
insert into BankAccount values(3,"SBI_ShivajiRoad",6000);
insert into BankAccount values(4,"SBI_ParlimentRoad",9000);
insert into BankAccount values(5,"SBI_Jantarmantar",8000);
insert into BankAccount values(6,"SBI_ShivajiRoad",4000);
insert into BankAccount values(8,"SBI_ResidencyRoad",4000);
insert into BankAccount values(9,"SBI_ParlimentRoad",3000);
insert into BankAccount values(10,"SBI_ResidencyRoad",5000);
insert into BankAccount values(11,"SBI_Jantarmantar",2000);

select * from bankAccount;

insert into BankCustomer values("Avinash","Bull_Temple_Road","Bangalore");
insert into BankCustomer values("Dinesh","Bannergatta_Road","Bangalore");
insert into BankCustomer values("Mohan","NationalCollege_Road","Bangalore");
insert into BankCustomer values("Nikil","Akbar_Road","Delhi");
insert into BankCustomer values("Ravi","Prithviraj_Road","Delhi");

insert into Depositer values("Avinash",1);
insert into Depositer values("Dinesh",2);
insert into Depositer values("Nikil",4);
insert into Depositer values("Ravi",5);
insert into Depositer values("Avinash",8);
insert into Depositer values("Nikil",9);
insert into Depositer values("Dinesh",10);
insert into Depositer values("Nikil",11);


insert into Loan values(1,"SBI_Chamrajpet",1000);
insert into Loan values(2,"SBI_ResidencyRoad",2000);
insert into Loan values(3,"SBI_ShivajiRoad",3000);
insert into Loan values(4,"SBI_ParlimentRoad",4000);
insert into Loan values(5,"SBI_Jantarmantar",5000);

select * from branch;

select * from BankAccount;

select * from BankCustomer;

select * from Depositer;

select * from Loan;

-- TO DO QUERIES

select Branch_name, CONCAT(assets/100000,'lakhs') assets_in_lakhs from branch;

select d.Customername from Depositer d, BankAccount b where b.Branch_name="SBI_ParlimentRoad" and d.Accno=b.Accno group by d.Customername having count(d.Accno)>=2;

create view sum_of_loan
as select Branch_name, SUM(Balance)
from BankAccount
group by Branch_name;

select * from sum_of_loan;

-- select bc.Customername, CONCAT(Balance+1000, 'rupees') as UPDATED_BALANCE from BankAccount b, BankCustomer bc, Depositer d where bc.Customercity='Bangalore';
-- -- where bc.Customername=d.Customername and b.Accno=d.Accno and

select bc.Customername, CONCAT(Balance+1000,' rupees')
UPDATED_BALANCE from BankAccount b, BankCustomer bc, Depositer d
where bc.Customername=d.Customername and b.Accno=d.Accno and
bc.Customercity='Bangalore';

SELECT * FROM LOAN ORDER BY AMOUNT DESC;


-- WEEK 4

create table Borrower (customer_name varchar(20), 
loan_number int, 
foreign key (customer_name) references bankcustomer(Customername),
foreign key (loan_number) references LOAN(loan_number));


insert into Borrower values('Avinash',1);
insert into Borrower values('Dinesh',2);
insert into Borrower values('Mohan',3);
insert into Borrower values('Nikil',4);
insert into Borrower values('Ravi',5);

select * from borrower;

select * from depositer;

SELECT * FROM depositer;

-- QUERIES


SELECT d.customername
FROM depositer d
JOIN bankaccount b ON d.accno = b.accno
JOIN branch br ON b.branch_name = br.branch_name
WHERE br.branch_city = 'Delhi'
GROUP BY d.customername
HAVING COUNT(DISTINCT br.branch_name) = (
    SELECT COUNT(*)
    FROM branch
    WHERE branch_city = 'Delhi'
);


SELECT DISTINCT customer_name
FROM borrower
WHERE customer_name NOT in (SELECT customername FROM depositer);

SELECT DISTINCT borrower.customer_name
FROM borrower, loan
WHERE borrower.loan_number = loan.loan_number
  AND loan.branch_name = 'Bangalore'
  AND (loan.branch_name, borrower.customer_name) IN
      (SELECT bankaccount.branch_name, depositer.customername
       FROM depositer, bankaccount
       WHERE depositer.accno = bankaccount.accno);

SELECT branch_name
FROM branch
WHERE assets > ANY (
    SELECT assets
    FROM branch
    WHERE branch_city = 'Bangalore'
);

-- Disable safe updates for the session
SET SQL_SAFE_UPDATES = 0;

-- Update all balances by 5%
UPDATE bankAccount
SET balance = balance * 1.05;

-- Re-enable safe updates (optional)
SET SQL_SAFE_UPDATES = 1;


DELETE FROM Depositer
WHERE accno IN (
    SELECT accno
    FROM bankAccount
    WHERE branch_name IN (
        SELECT branch_name
        FROM branch
        WHERE branch_city = 'Bombay'
    )
);





