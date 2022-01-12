require "csv"

class DocsController < ApplicationController
  def index
    @docs = Doc.all
  end

  def new
    @doc = Doc.new
  end

  def create

    upload = params[:doc][:attachment]
    path = Rails.root.join('public', 'uploads', upload.original_filename)

    File.open(path, 'wb') do |file|
      file.write(upload.read)
    end

    parsed = CSV.read(path, col_sep: "\t")

    puts parsed[1]

    # @doc = Doc.new(docs_params)
    # if @doc.save
    #   redirect_to "/", notice: "Successfully uploaded."
    # else
    #   render "new"
    # end

  end

  def destroy
    @doc = Doc.find(params[:id])
    @doc.destroy
    redirect_to "/", notice:  "Successfully deleted."
  end

  private
    def docs_params
    params.require(:doc).permit(:name,:attachment)
  end

end
