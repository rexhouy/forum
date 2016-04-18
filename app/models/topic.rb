require 'elasticsearch/model'
class Topic < ActiveRecord::Base
        has_many :posts
        has_many :enrolls
        belongs_to :user
        has_many :user_favorites
        has_many :questions
        accepts_nested_attributes_for :questions

        validates :title, presence: true
        validates :content, presence: true

        before_create do
                self.favorite = 0
        end

        # full text index
        include Elasticsearch::Model
        include Elasticsearch::Model::Callbacks

        def as_indexed_json(options = {})
                as_json(only: ["id", "title"])
        end

        def self.search(search_text)
                search_params = {
                        query: {
                                match: { title: search_text }
                        },
                        from: 0,
                        size: 50
                }
                __elasticsearch__.search(search_params).records
        end

        def need_payment?
                enroll_fee.present?
        end

        def has_questions?
                questions.any?
        end

        def enroll_started?
                Time.current >= enroll_start_date
        end

        def enroll_ended?
                Time.current > enroll_end_date
        end

        def enroll_finished?
                enrolls.size >= max_places
        end

end
Topic.import # for auto sync model with elastic search
