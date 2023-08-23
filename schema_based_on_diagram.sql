CREATE DATABASE clinic;

CREATE TABLE patients(id INT GENERATED ALWAYS AS IDENTITY,
name VARCHAR,
date_of_birth DATE,
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

CREATE TABLE medical_histories(id INT GENERATED ALWAYS AS IDENTITY,
patient_id INT REFERENCES patients(id),
admited_at TIMESTAMP,
status VARCHAR,
PRIMARY KEY(id)
);

ALTER TABLE medical_histories ADD CONSTRAINT fk_patients FOREIGN KEY (patient_id) REFERENCES patients(id);
ALTER TABLE invoices ADD CONSTRAINT fk_medical_histories FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id);
ALTER TABLE invoice_items ADD CONSTRAINT fk_treatments FOREIGN KEY (treatment_id) REFERENCES treatments(id);
ALTER TABLE invoice_items ADD CONSTRAINT fk_invoices FOREIGN KEY (invoice_id) REFERENCES invoices(id);
ALTER TABLE medical_histories_treatments ADD CONSTRAINT fk_treatments FOREIGN KEY (treatment_id) REFERENCES treatments(id);
ALTER TABLE medical_histories_treatments ADD CONSTRAINT fk_histories FOREIGN KEY (medical_histories_id) REFERENCES medical_histories(id);

CREATE INDEX idx_patient_id ON medical_histories(patient_id);
CREATE INDEX idx_medical_history_id ON invoices(medical_history_id);
CREATE INDEX idx_invoice_id ON invoice_items(invoice_id);
CREATE INDEX idx_treatment_id ON invoice_items(treatment_id);
CREATE INDEX idx_medical_histories_id ON medical_histories_treatments(medical_histories_id);
CREATE INDEX idx_treatments_id ON medical_histories_treatments(treatment_id);