class TenantsController < ApplicationController

    def index
        render json: Tenant.all, status: ok
    end

    def show
        render json: Tenant.find_by(id: params[:id])
    end

    def create
        tenant = Tenant.create(tenant_params)
        if tenant.valid?
            render json: tenant, status: :ok
        else 
            render json: {
                error: tenant.errors.full_messages
            }, status: :unprocessable_entity 
        end 
    end

    def update
        tenant = Tenant.find_by(id: params[:id])
        if tenant
            tenant.update(tenant_params)
            if tenant.valid?
                render json: tenant, status: :ok
            else
                render json: {error: tenant.errors.full_messages}
            end
        else 
            render json: {
                error: "Tenant not found!"
            }, status: 404
        end 
    end

    def destroy
        Tenant.find_by(id: params[:id]).destroy
        render head :no_content
    end

    private

    def tenant_params
        params.permit(:name, :age)
    end

end
