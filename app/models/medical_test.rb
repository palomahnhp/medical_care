class MedicalTest < ApplicationRecord
  paginates_per 10

  belongs_to :appointment, optional: true
  belongs_to :patient
  belongs_to :professional
  belongs_to :medical_center

  has_many   :analysis_results
  has_many   :analytical_items, through: :analysis_results


  scope :by_patient, ->(patient) { where(patient: patient) }

end