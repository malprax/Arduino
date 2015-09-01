namespace :delete do
	desc	'Delete old billings'
	task	:remove_billings => :environment  do
    puts "Mulai Menghapus Billing Kemarin...."
    if Billing.expiration == Billing.tomorrow
      Billing.copy_to_reports
      Billing.destroy
    end
    puts "Selesai Hapus Billing Kemarin"
	end
end