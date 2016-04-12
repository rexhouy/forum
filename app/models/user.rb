# -*- coding: utf-8 -*-
class User < ActiveRecord::Base
        # Include default devise modules. Others available are:
        # :confirmable, :lockable, :timeoutable and :omniauthable
        devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :lockable, authentication_keys: [:tel]

        before_create do
                self.role ||= User.roles[:user]
                self.active = true
        end

        enum role: [:user, :admin, :partener]
        validates :tel, presence: true, length: { is: 11 }, uniqueness: { message: "已经被使用" }
        validates :name, uniqueness: {  message: "已经被使用！" }

        def email_required?
                false
        end

        def self.reset_password_by_token(attributes={})
                recoverable = find_or_initialize_with_error_by(:tel, attributes[:tel])
                unless recoverable.nil?
                        recoverable.reset_password!(attributes[:password], attributes[:password_confirmation])
                else
                        recoverable.errors.add(:tel, "不存在")
                end
                recoverable
        end

        ## validate user when sign in
        def active_for_authentication?
                super && self.active
        end

end
