ActiveAdmin.register Sheet do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :phenotype_id, :cultivation_id, technique_ids: [],
                germination_attributes: [
                  :id, :_destroy, :start_date, :end_date, :estimated_end_date,
                  logs_attributes: %i[id _destroy entry image data]
                ],
                vegetative_attributes: [
                  :id, :_destroy, :start_date, :end_date, :estimated_end_date,
                  logs_attributes: %i[id _destroy entry height feeded trained pruned image data]
                ],
                flowering_attributes: [
                  :id, :_destroy, :start_date, :end_date, :estimated_end_date,
                  logs_attributes: %i[id _destroy entry height feeded trained pruned image data]
                ]


      # t.text :data
      # t.integer :height
      # t.boolean :feeded
      # t.boolean :trained
      # t.boolean :pruned

  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :phenotype_id, :cultivation_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  show do
    panel I18n.t('admin.sheet.basic_info') do
      attributes_table_for sheet do
        row :name
        list_row :techniques do |sheet|
          sheet.techniques.map(&:name)
        end
        row :phenotype
        row :cultivation
      end
    end
    panel I18n.t('admin.sheet.germination') do
      attributes_table_for sheet.germination do
        row :start_date
        row :end_date
        row :estimated_end_date
        table_for sheet.germination.logs do
          column :entry
          column :image, class: 'thumbnail' do |log|
            image_tag(log.image, size: '68x68')
          end
          column :data
        end
      end
    end
    panel I18n.t('admin.sheet.vegetative') do
      attributes_table_for sheet.vegetative do
        row :start_date
        row :end_date
        row :estimated_end_date
        table_for sheet.vegetative.logs do
          column :entry
          column :height
          column :feeded
          column :trained
          column :pruned
          column :image, class: 'thumbnail' do |log|
            image_tag(log.image, size: '68x68')
          end
          column :data
        end
      end
    end
    panel I18n.t('admin.sheet.flowering') do
      attributes_table_for sheet.flowering do
        row :start_date
        row :end_date
        row :estimated_end_date
        table_for sheet.flowering.logs do
          column :entry
          column :height
          column :feeded
          column :trained
          column :pruned
          column :image, class: 'thumbnail' do |log|
            image_tag(log.image)
          end
          column :data
        end
      end
    end
  end

  form html: { multipart: true } do |f|
    f.semantic_errors(*f.object.errors.keys)
    f.object.germination ||= Germination.new
    f.object.vegetative ||= Vegetative.new
    f.object.flowering ||= Flowering.new
    tabs do
      tab I18n.t('admin.sheet.basic_info') do
        f.inputs do
          f.input :name
          f.input :technique_ids,
                  as: :tags,
                  label: I18n.t('activerecord.attributes.sheet.techniques'),
                  collection: Technique.all
          f.input :phenotype, as: :select, collection: Phenotype.all
          f.input :cultivation, as: :select, collection: Cultivation.all
        end
      end
      tab I18n.t('admin.sheet.germination') do
        f.has_many :germination, heading: '', class: 'has_one' do |g|
          g.input :start_date, as: :date_time_picker, picker_options: { timepicker: false }
          g.input :end_date, as: :date_time_picker, picker_options: { timepicker: false }
          g.input :estimated_end_date, as: :date_time_picker, picker_options: { timepicker: false }
          g.has_many :logs, allow_destroy: true do |l|
            l.input :entry, as: :date_time_picker
            l.input :image, class: 'thumbnail', as: :file, hint: l.object.image.present? ? image_tag(l.object.image) : content_tag(:span, 'no image')
            l.input :data, input_html: { rows: 5 }
          end
        end
      end
      tab I18n.t('admin.sheet.vegetative') do
        f.has_many :vegetative, heading: '', class: 'has_one' do |g|
          g.input :start_date, as: :date_time_picker, picker_options: { timepicker: false }
          g.input :end_date, as: :date_time_picker, picker_options: { timepicker: false }
          g.input :estimated_end_date, as: :date_time_picker, picker_options: { timepicker: false }
          g.has_many :logs, allow_destroy: true do |l|
            l.input :entry, as: :date_time_picker
            l.input :height
            l.input :feeded
            l.input :trained
            l.input :pruned
            l.input :image, as: :file, hint: l.object.image.present? ? image_tag(l.object.image) : content_tag(:span, 'no image')
            l.input :data, input_html: { rows: 5 }
          end
        end
      end
      tab I18n.t('admin.sheet.flowering') do
        f.has_many :flowering, heading: '', class: 'has_one' do |g|
          g.input :start_date, as: :date_time_picker, picker_options: { timepicker: false }
          g.input :end_date, as: :date_time_picker, picker_options: { timepicker: false }
          g.input :estimated_end_date, as: :date_time_picker, picker_options: { timepicker: false }
          g.has_many :logs, allow_destroy: true do |l|
            l.input :entry, as: :date_time_picker
            l.input :height
            l.input :feeded
            l.input :trained
            l.input :pruned
            l.input :image, as: :file, hint: l.object.image.present? ? image_tag(l.object.image) : content_tag(:span, 'no image')
            l.input :data, input_html: { rows: 5 }
          end
        end
      end
    end
    f.actions
  end

  #   script do
  #     raw "$.fn.select2.defaults.set(
  #       'language',
  #       $.fn.select2.amd.require('select2/i18n/#{I18n.locale}')
  #     );"
  #   end
  # end
end
