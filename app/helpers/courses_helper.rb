module CoursesHelper
  def replace_id_collection
    # New location
    @course_params[:locations].map! do |l|
     l = Location.find(l)
    end

    # New category
    @course_params[:categories].map! do |c|
      c = Category.find(c)
    end

    # Create prerequisites
    @course_params[:prerequisites].map! do |p|
      p = Prerequisite.where(id: p).first_or_create
    end
  end

  # Assign user
  def assign_to_course_params(hash)
    hash.each do |key, value|
      @course_params[key] = value
    end
  end

  def clean_params
    # Clean array if it contains an empty string
    @course_params.each do |k, v|
      @course_params[k].clean_empty if @course_params[k].kind_of?(Array)
    end
  end
end
