class  IssuesController < ApplicationController

  def index

  end

  def show
    @test_response = {
      issue: {
        summary: 'there is something wrong with something',
        comments: [
          {comment: 'this is a comment',
            author: 'JM'
          },
          {comment: 'this is another comment',
            author: 'JM'
          }
        ],
        meta: {
          labels: ['label1', 'label2']
        }
      },

      feedback: {
        data: 'data'
      }
    }

    render json: @test_response
  end

  def search

  end

  def results

  end

end
