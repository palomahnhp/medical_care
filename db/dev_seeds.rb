require 'database_cleaner'
DatabaseCleaner.clean_with :truncation
DatabaseCleaner.clean

p 'Creating user ...'
user = User.find_or_create_by!(email: Rails.application.secrets.user_email) do |user|
  user.password = Rails.application.secrets.user_password
  user.password_confirmation = Rails.application.secrets.user_password

end

p  'Creating Pacients ...'
[
 ['Cherry', 'Sara',   'Beltrán Hernández', '1998/03/26'],
 ['Popi',   'Paloma', 'Hernández Navarro', '1961/08/02'],
 ['Jb',    'Justo',  'Beltrán Vicente', '1964/06/22']
].each do |reg|
  patient =  Patient.create(nickname: reg[0], firstname: reg[1], surname: reg[2], born_date: reg[3])
  p patient.nickname + ' ' + patient.firstname + ' ' + patient.surname + ' ' + patient.born_date.to_s
end

p  'Creating Centers ...'
[
 ['Hospital del Sureste', 'Arganda del Rey', 'Público',
  'http://www.madrid.org/cs/Satellite?language=es&pagename=HospitalSureste%2FPage%2FHSES_home',
  'citas.sureste@salud.madrid.org'],
 ['Centro de Salud Primero de Mayo', 'Calle Velazquez, Rivas Vaciamadrid', 'Público', '', ''],
 ['Hospital Gregorio Marañon', 'Madrid', 'Público'],
 ['Cetro Médico Lagos de Rivas', 'Av. de Levante, Rivas Vaciamadrid', 'Privado',
  'http://lagosderivas.com', ''],
].each do |reg|
  centro =  MedicalCenter.create(name: reg[0], address: reg[1], kind: reg[2], web: reg[3], email: reg[4])
  p centro.name
end

p  'Creating Specialities ...'
%w(Alergología Anestesiología Cardiología Gastroenterología Endocrinología Geriatría
   Hematología Infectología General Nefrología Neumología Neurología Nutriología Oftalmología
   Oncología Pediatría Psiquiatría Rehabilitación Reumatología Toxicología Enfermería
   Urología).each do |reg|
   specialiy = Speciality.create(denomination: reg)
   p specialiy.denomination
end
p  'Creating Profesionals ...'
 [
     ['Rebeca', 'Manzano', 'Gastroenterología', 'Hospital del Sureste'],
     ['Mª José', 'Garrido', 'General', 'Centro de Salud Primero de Mayo'],
     ['Marta', 'Fernando', 'Enfermería', 'Centro de Salud Primero de Mayo']
 ].each do |reg|
   professional =  Professional.create(firstname: reg[0], surname: reg[1],
                                       speciality: Speciality.find_by(denomination: reg[2]),
                                       medical_center: MedicalCenter.find_by(name: reg[3]))
   p professional.firstname
 end

p 'Creating appointments ... '

  Patient.all.each do |patient|
    (1..3).each do |n|
      a = Appointment.create(patient: patient,
                         appointment_time:rand((Time.current - 2.years) .. (Time.current + 3.months)),
                         professional: Professional.all.shuffle.first,
                         medical_center: MedicalCenter.all.shuffle.first,
                         reason: Faker::Lorem.paragraph,
                         location: 'planta ' + (rand(1..5).to_s) +' despacho ' + (rand(102..215).to_s))

    end
  end

 p 'Creating histories ... '
   Appointment.all.each do |appointment|
     h = History.create(patient: appointment.patient, appointment: appointment, note: "<p>#{Faker::Lorem.paragraphs.join('</p><p>')}</p>")
   end

   (1..5).each do |n|
     History.create(
         patient: Patient.all.shuffle.first,
         note: "<p>#{Faker::Lorem.paragraphs.join('</p><p>')}</p>"
     )
   end

   medicaments = [
     {'PARACETAMOL Comp. 1 g': 'Paracetamol'}, {'IBUPROFENO Comp. recub. con película 600 mg':  'Ibuprofeno'},
     {'AMOXICILINA + ACIDO CLAVULANICO Comp. recub. con película 875/125 mg': 'Amoxicilina y ácido clavulánico'},
     {'ACFOL Comp. 5 mg': 'Ácido fólico'}, {'SILVEDERMA Crema 10 mg/g': 'Sulfadiazina argéntica'}
   ]
   (1..5).each do |n|
     Medication.create(
       name: medicaments[n-1].keys[0],
       active_ingredient: medicaments[n-1].values[0]
     )
   end


p 'Analytic groups'
  %w(Hematología Bioquica Orina Hormonal).each do |group|
    AnalyticalGroup.create(name: group)
  end

p 'Analytical items'
  [{'Leucocitos': 'Hematología'}, {'Hematies': 'Hematología'},
   {'Trigliceridos': 'Bioquímica'}].each do |item|
    AnalyticalItem.create()
  end

p 'Analisys'
   analisis = Analysis.create(
               patient: Patient.first,
               appointment: Appointment.first,
               medical_center: MedicalCenter.first,
               extracted_at: Date.today - 2.months
   )

AnalyticalItem.all.each do |item|
 AnalysisResult.create(
   analysis: Analysis.first,
   analytical_item: item,
   amount: 13.25,
   magnitude: ['*', 'A', ' '].shuffle.first
 )
end