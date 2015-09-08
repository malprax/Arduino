namespace :delete do
	desc	'remove billings'
	task	:remove_billings => :environment  do
    puts "Mulai Menghapus Billing Kemarin...."
    Billing.copy_to_reports
    puts "Selesai Hapus Billing Kemarin"
	end
end