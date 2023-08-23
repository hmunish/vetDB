CREATE DATABASE clinic;

CREATE TABLE patients(id INT GENERATED ALWAYS AS IDENTITY,
name VARCHAR,
date_of_birth DATE,
PRIMARY KEY(id)
);

CREATE TABLE medical_histories(id INT GENERATED ALWAYS AS IDENTITY,
patient_id INT REFERENCES patients(id),
admited_at TIMESTAMP,
status VARCHAR,
PRIMARY KEY(id)
);

CREATE TABLE treatments(id INT GENERATED ALWAYS AS IDENTITY,
name VARCHAR,
type VARCHAR,
PRIMARY KEY(id)
);

CREATE TABLE invoices(id INT GENERATED ALWAYS AS IDENTITY,
generated_at TIMESTAMP,
payed_at TIMESTAMP,
total_amount DECIMAL,
medical_history_id INT REFERENCES medical_histories(id),
PRIMARY KEY(id)
);

CREATE TABLE invoice_items(id INT GENERATED ALWAYS AS IDENTITY,
quantity INT,
total_price DECIMAL,
unit_price DECIMAL,  
invoice_id INT REFERENCES invoices(id),
treatment_id INT REFERENCES treatments(id),
PRIMARY KEY(id)
);

CREATE TABLE medical_histories_treatments(
id INT GENERATED ALWAYS AS IDENTITY,
medical_histories_id INT REFERENCES medical_histories(id),
treatment_id INT REFERENCES treatments(id),
PRIMARY KEY(id);
);