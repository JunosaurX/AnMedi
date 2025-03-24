-- Create the drugs table
CREATE TABLE IF NOT EXISTS drugs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    description TEXT,
    side_effects TEXT,
    dosage TEXT,
    uses TEXT
);

-- Insert 50 real drug records into the database for testing
INSERT INTO drugs (name, description, side_effects, dosage, uses)
VALUES
    ('Aspirin', 'Aspirin is used to reduce fever and inflammation.', 'Stomach pain, nausea', '300mg to 1000mg, every 4 to 6 hours', 'Pain relief, fever reducer, anti-inflammatory'),
    ('Atorvastatin', 'Atorvastatin is used to lower cholesterol and reduce the risk of heart disease.', 'Muscle pain, liver damage', '10mg to 80mg daily', 'Lower cholesterol, reduce heart disease risk'),
    ('Azithromycin', 'Azithromycin is an antibiotic used to treat bacterial infections.', 'Diarrhea, nausea, stomach pain', '250mg to 500mg daily', 'Bacterial infections'),
    ('Ciprofloxacin', 'Ciprofloxacin is an antibiotic used to treat a variety of bacterial infections.', 'Nausea, diarrhea, headache', '250mg to 750mg every 12 hours', 'Bacterial infections'),
    ('Clonazepam', 'Clonazepam is used to prevent and control seizures and panic attacks.', 'Drowsiness, dizziness, memory problems', '0.25mg to 1mg daily', 'Seizures, panic disorder'),
    ('Diazepam', 'Diazepam is used to treat anxiety, muscle spasms, and seizures.', 'Drowsiness, dizziness, tiredness', '2mg to 10mg daily', 'Anxiety, muscle spasms, seizures'),
    ('Doxycycline', 'Doxycycline is an antibiotic used to treat infections and prevent malaria.', 'Nausea, diarrhea, sensitivity to sunlight', '100mg to 200mg daily', 'Bacterial infections, malaria prevention'),
    ('Enalapril', 'Enalapril is used to treat high blood pressure and heart failure.', 'Dizziness, headache, dry cough', '2.5mg to 40mg daily', 'High blood pressure, heart failure'),
    ('Esomeprazole', 'Esomeprazole is used to treat gastroesophageal reflux disease (GERD) and other stomach acid-related conditions.', 'Headache, diarrhea, nausea', '20mg to 40mg daily', 'GERD, acid reflux'),
    ('Fluoxetine', 'Fluoxetine is used to treat depression, panic attacks, and other mental health conditions.', 'Nausea, insomnia, sexual dysfunction', '10mg to 40mg daily', 'Depression, anxiety, panic attacks'),
    ('Gabapentin', 'Gabapentin is used to treat seizures and nerve pain.', 'Drowsiness, dizziness, swelling', '100mg to 800mg daily', 'Seizures, nerve pain'),
    ('Hydrochlorothiazide', 'Hydrochlorothiazide is used to treat high blood pressure and fluid retention.', 'Dizziness, headache, low potassium levels', '12.5mg to 50mg daily', 'High blood pressure, edema'),
    ('Ibuprofen', 'Ibuprofen is used to reduce fever and inflammation.', 'Nausea, headache, stomach pain', '200mg to 400mg every 4 to 6 hours', 'Pain relief, fever reducer, anti-inflammatory'),
    ('Insulin', 'Insulin is used to control blood sugar levels in people with diabetes.', 'Low blood sugar, weight gain', 'Injected according to blood sugar levels', 'Diabetes management'),
    ('Lisinopril', 'Lisinopril is used to treat high blood pressure and heart failure.', 'Dizziness, cough, headache', '10mg to 40mg daily', 'High blood pressure, heart failure'),
    ('Lorazepam', 'Lorazepam is used to treat anxiety and seizures.', 'Drowsiness, dizziness, blurred vision', '0.5mg to 2mg daily', 'Anxiety, seizures'),
    ('Metformin', 'Metformin is used to control blood sugar levels in people with type 2 diabetes.', 'Stomach upset, diarrhea, lactic acidosis (rare)', '500mg to 1000mg, twice a day', 'Type 2 diabetes management'),
    ('Methylprednisolone', 'Methylprednisolone is used to treat inflammation and conditions such as allergies and arthritis.', 'Increased appetite, weight gain, insomnia', '4mg to 48mg daily', 'Inflammation, autoimmune conditions'),
    ('Morphine', 'Morphine is used to treat moderate to severe pain.', 'Drowsiness, constipation, nausea', '2mg to 10mg every 4 hours', 'Severe pain relief'),
    ('Naproxen', 'Naproxen is used to reduce inflammation, pain, and fever.', 'Nausea, headache, stomach pain', '250mg to 500mg every 12 hours', 'Pain relief, anti-inflammatory'),
    ('Omeprazole', 'Omeprazole is used to treat gastroesophageal reflux disease (GERD) and stomach ulcers.', 'Headache, diarrhea, nausea', '20mg to 40mg daily', 'GERD, stomach ulcers'),
    ('Oxycodone', 'Oxycodone is used to treat moderate to severe pain.', 'Drowsiness, constipation, nausea', '5mg to 10mg every 4 to 6 hours', 'Pain relief'),
    ('Prednisone', 'Prednisone is used to treat inflammation and immune system disorders.', 'Weight gain, fluid retention, mood changes', '5mg to 60mg daily', 'Inflammation, autoimmune diseases'),
    ('Propranolol', 'Propranolol is used to treat high blood pressure, anxiety, and prevent heart attacks.', 'Dizziness, fatigue, slow heart rate', '40mg to 160mg daily', 'High blood pressure, anxiety, heart attack prevention'),
    ('Ramipril', 'Ramipril is used to treat high blood pressure and heart failure.', 'Dizziness, headache, cough', '2.5mg to 10mg daily', 'High blood pressure, heart failure'),
    ('Ranitidine', 'Ranitidine is used to treat stomach ulcers and GERD.', 'Headache, constipation, dizziness', '150mg to 300mg daily', 'GERD, stomach ulcers'),
    ('Simvastatin', 'Simvastatin is used to lower cholesterol and reduce the risk of heart disease.', 'Muscle pain, liver damage', '10mg to 40mg daily', 'Lower cholesterol, reduce heart disease risk'),
    ('Spironolactone', 'Spironolactone is used to treat high blood pressure, fluid retention, and hormonal imbalances.', 'Dizziness, headache, high potassium levels', '25mg to 100mg daily', 'High blood pressure, fluid retention'),
    ('Tramadol', 'Tramadol is used to treat moderate to severe pain.', 'Drowsiness, nausea, constipation', '50mg to 100mg every 4 to 6 hours', 'Pain relief'),
    ('Warfarin', 'Warfarin is used to prevent blood clots in people with certain conditions.', 'Bleeding, bruising, nausea', '2mg to 10mg daily', 'Blood clot prevention');

-- Add more drugs as needed...