class UserResource < Microbe::Resource::Base
  collection :list do
    [
      User.new(name: 'name', surname: 'surname')
    ]
  end

  member :show do
    User.new(name: 'name', surname: 'surname')
  end

  collection :update, method: :post do
    User.new(name: params[:name], surname: params[:surname]])
  end
end
