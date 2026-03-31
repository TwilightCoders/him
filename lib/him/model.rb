require "him/model/base"
require "him/model/http"
require "him/model/attributes"
require "him/model/relation"
require "him/model/orm"
require "him/model/parse"
require "him/model/associations"
require "him/model/introspection"
require "him/model/paths"
require "him/model/nested_attributes"
require "active_model"

module Him
  # This module is the main element of Her. After creating a Him::API object,
  # include this module in your models to get a few magic methods defined in them.
  #
  # @example
  #   class User
  #     include Him::Model
  #   end
  #
  #   @user = User.new(:name => "Rémi")
  #   @user.save
  module Model
    extend ActiveSupport::Concern

    # Her modules
    include Him::Model::Base
    include Him::Model::Attributes
    include Him::Model::ORM
    include Him::Model::HTTP
    include Him::Model::Parse
    include Him::Model::Introspection
    include Him::Model::Paths
    include Him::Model::Associations
    include Him::Model::NestedAttributes

    # Supported ActiveModel modules
    include ActiveModel::AttributeMethods
    include ActiveModel::Validations
    include ActiveModel::Validations::Callbacks
    include ActiveModel::Conversion
    include ActiveModel::Dirty

    # Override ActiveModel::Dirty's attribute_changed_in_place? to use
    # Her's change tracking. This allows validates_numericality_of to work.
    def attribute_changed_in_place?(attribute_name)
      !changes[attribute_name.to_s].nil?
    end

    # Class methods
    included do
      # Assign the default API
      use_api Him::API.default_api
      method_for :create, :post
      method_for :update, :put
      method_for :find, :get
      method_for :destroy, :delete
      method_for :new, :get

      # Define the default primary key
      primary_key :id

      # Define default storage accessors for errors and metadata
      store_response_errors :response_errors
      store_metadata :metadata

      # Include ActiveModel naming methods
      extend ActiveModel::Translation

      # Configure ActiveModel callbacks
      extend ActiveModel::Callbacks
      define_model_callbacks :create, :update, :save, :find, :destroy, :initialize

      # Define matchers for attr? and attr= methods
      define_attribute_method_matchers
    end
  end
end
