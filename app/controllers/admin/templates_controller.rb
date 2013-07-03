class Admin::TemplatesController < Admin::AdminController
  
  def index
    @templates = Template.all
    @template = Template.new
  end
  
  def edit
    @template = Template.find(params[:id])
    @templates = Template.all
  end
    
  def new
    @template = Template.new
    @templates = Template.all
  end
    
  def create    
    @template = Template.create(params[:template])
    @templates = Template.where(true)
    if @template.save
      flash[:alert] = "#{Settings.templates.singular} successfully created"
      redirect_to edit_admin_template_path(@template)
    else
      flash[:alert] = "All fields are required"
      render :new
    end
  end
  
  def update
    @template = Template.find(params[:id])
    @template.update_attributes(params[:template])
    if @template.save
      @templates = Template.where(true)
      flash[:alert] = "#{Settings.templates.singular} successfully updated"
      redirect_to edit_admin_template_path(@template)
    else
      flash[:alert] = "All fields are required"
      render :edit
    end
  end
  
  def sort
    params[:components].each_with_index do |id, index|
      TemplateComponent.update_all({order: index+1}, {template_id: params[:id], component_id: id})
    end 
    render nothing: true
  end
  
  def add_component
    @template = Template.find(params[:id])
    @component = Component.find(params[:component_id])
    template_component = TemplateComponent.new
    template_component.template = @template
    template_component.component = @component
    template_component.save!
  end
  
  def remove_component
    @template_component = TemplateComponent.find_by_template_id_and_component_id(params[:id], params[:component_id])
    template = @template_component.template
    component = @template.components.find(params[:component_id])
    
    if template
      template.components.delete(component)
    end
    
  end
  
end
