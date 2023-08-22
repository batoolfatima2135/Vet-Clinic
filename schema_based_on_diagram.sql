CREATE TABLE patients(
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(250),
  date_of_birth DATE,
  PRIMARY KEY (id)
);

CREATE TABLE medical_histories(
  id INT GENERATED ALWAYS AS IDENTITY,
  admitted_at timestamp,
  patient_id INT REFERENCES patients(id),
  status VARCHAR(250),
  PRIMARY KEY(id)  
);
CREATE INDEX idx_patient_id ON medical_histories(patient_id);

CREATE TABLE invoices(
  id INT GENERATED ALWAYS AS IDENTITY,
  total_amount DECIMAL,
  generated_id timestamp,
  payed_at timestamp,
  medical_history__id INT REFERENCES medical_histories(id), 
  PRIMARY KEY(id)
);
CREATE INDEX idx_medical_history__id ON invoices(medical_history__id);

CREATE TABLE invoice_items (
  id INT GENERATED ALWAYS AS IDENTITY,
  unit_price DECIMAL,
  quantity INT,
  total_price DECIMAL,
  invoice_id INT REFERENCES invoices(id),
  PRIMARY KEY(id)
);
CREATE INDEX idx_invoice_id  ON invoice_items(invoice_id );  


CREATE TABLE treatments(
   id INT GENERATED ALWAYS AS IDENTITY,
   type VARCHAR(250),
   name VARCHAR(250),
   PRIMARY KEY(id)
);

CREATE TABLE join_table(
  id INT GENERATED ALWAYS AS IDENTITY,
  treatment_id INT REFERENCES treatments(id),
  medical_history__id INT REFERENCES medical_histories(id),
  PRIMARY KEY(id)
);
CREATE INDEX idx_treatment_id ON join_table(treatment_id);
CREATE INDEX idx_medical_history_id ON join_table(medical_history__id);