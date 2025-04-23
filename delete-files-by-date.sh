#!/bin/bash

# Meminta input tahun, bulan, dan tanggal
read -p "Masukkan Tahun (YYYY): " YEAR
read -p "Masukkan Bulan (MM): " MONTH
read -p "Masukkan Tanggal (DD): " DAY

# Folder tempat file berada (ganti sesuai kebutuhan)
FOLDER="/mnt/data/dump"

# Pastikan input tidak kosong
if [[ -z "$YEAR" || -z "$MONTH" || -z "$DAY" ]]; then
    echo "Input tidak boleh kosong!"
    exit 1
fi

# Format tanggal
START_DATE="${YEAR}-${MONTH}-${DAY} 00:00:00"
END_DATE="${YEAR}-${MONTH}-$(printf "%02d" $((DAY+1))) 00:00:00"

# Menampilkan file yang akan dihapus (opsional)
echo "File yang akan dihapus dari tanggal $YEAR-$MONTH-$DAY:"
find "$FOLDER" -type f -newermt "$START_DATE" ! -newermt "$END_DATE"

# Konfirmasi sebelum menghapus
read -p "Apakah Anda yakin ingin menghapus file ini? (y/n): " CONFIRM
if [[ "$CONFIRM" == "y" || "$CONFIRM" == "Y" ]]; then
    find "$FOLDER" -type f -newermt "$START_DATE" ! -newermt "$END_DATE" -exec rm -v {} \;
    echo "File berhasil dihapus."
else
    echo "Penghapusan dibatalkan."
fi