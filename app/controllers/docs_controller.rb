require "csv"

class DocsController < ApplicationController

  def create

    upload = params[:doc][:attachment]
    path = Rails.root.join('public', 'uploads', upload.original_filename)

    File.open(path, 'wb') do |file|
      file.write(upload.read)
    end

    parsed = CSV.read(path, col_sep: "\t")

    puts parsed[1]

    # `purchaser name`, `item description`, `item price`, `purchase count`, `merchant address`, `merchant name`

    # @doc = Doc.new(docs_params)
    # if @doc.save
    #   redirect_to "/", notice: "Successfully uploaded."
    # else
    #   render "new"
    # end

  end

  private
    def docs_params
    params.require(:doc).permit(:attachment)
  end

end
