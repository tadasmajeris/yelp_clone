module WithUserAssociationExtension

  def build_with_user(params = {}, user)
    params[:user] ||= user
    build(params)
  end

  def create_with_user(params = {}, user)
    params[:user] ||= user
    create(params)
  end

  def create_with_user!(params = {}, user)
    params[:user] ||= user
    create!(params)
  end

end
