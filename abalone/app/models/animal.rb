class Animal < ApplicationRecord
  has_paper_trail

  include OrganizationScope
  include CsvExportable
  include ReportsKit::Model

  reports_kit do
    contextual_filter :for_organization, ->(relation, context_params) { relation.for_organization(context_params[:organization_id]) }
  end

  belongs_to :cohort, optional: true
  has_many :measurements, as: :subject
  has_many :animals_shl_numbers, dependent: :destroy
  has_many :shl_numbers, through: :animals_shl_numbers
  has_one :mortality_event

  validates :tag, uniqueness: { scope: %i[cohort_id] }

  delegate :name, to: :cohort, prefix: true, allow_nil: true

  after_initialize :set_default_sex, if: :new_record?

  enum sex: {
    unknown: 'unknown',
    male: 'male',
    female: 'female'
  }

  def set_default_sex
    self.sex ||= :unknown
  end

  def shl_number_codes(join = ",")
    shl_numbers.pluck(:code).join(join)
  end

  def alive?
    !dead?
  end

  def dead?
    mortality_event.present?
  end
end
