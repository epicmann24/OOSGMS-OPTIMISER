#!/system/bin/sh
mkdir -p /data/local/tmp/empty

mount --bind /data/local/tmp/empty /system_ext/app/CrashBox
mount --bind /data/local/tmp/empty /system_ext/app/EidService
mount --bind /data/local/tmp/empty /system_ext/app/LogKit
mount --bind /data/local/tmp/empty /system_ext/app/Olc
mount --bind /data/local/tmp/empty /system_ext/app/OplusLocationService
mount --bind /data/local/tmp/empty /system_ext/app/OTrace
mount --bind /data/local/tmp/empty /system_ext/app/QCC
mount --bind /data/local/tmp/empty /system_ext/app/LFEHer
mount --bind /data/local/tmp/empty /system_ext/app/OplusQualityProtect
mount --bind /data/local/tmp/empty /system_ext/priv-app/com.qualcomm.location
mount --bind /data/local/tmp/empty /product/app/StdSP
mount --bind /data/local/tmp/empty /product/app/LocationProxy
mount --bind /data/local/tmp/empty /product/priv-app/DCS
mount --bind /data/local/tmp/empty /product/priv-app/Metis
mount --bind /data/local/tmp/empty /vendor/app/TxPwrAdmin
mount --bind /data/local/tmp/empty /vendor/app/TrustZoneAccessService
mount --bind /data/local/tmp/empty /system_ext/priv-app/xrvdservice/
mount --bind /data/local/tmp/empty /product/app/DeviceStatisticsService/

exit 0
