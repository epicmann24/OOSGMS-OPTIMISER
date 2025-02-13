#!/system/bin/sh
exec > /cache/OOSGMS.txt 2>&1
echo "Script pre execution"
while true; do
    LOCK_STATE=$(dumpsys window | grep "mDreamingLockscreen=" | sed 's/.*mDreamingLockscreen=//')
    if [ "$LOCK_STATE" = "true" ] || [ "$LOCK_STATE" = "false" ]; then
        break
    fi
    echo "Paused script, waiting for unlock"
    sleep 5
done
echo "Script begining"
c="pm disable"
g="com.google.android.gms/com.google.android.gms"
$c "${g}.analytics.AnalyticsTaskService"
$c "${g}.analytics.internal.PlayLogReportingService"
$c "${g}.analytics.service.AnalyticsService"
$c "${g}.analytics.AnalyticsReceiver"
$c "${g}.ads.AdRequestBrokerService"
$c "${g}.measurement.service.MeasurementBrokerService"
$c "${g}.measurement.PackageMeasurementService"
$c "${g}.measurement.PackageMeasurementReceiver"
$c "${g}.measurement.AppMeasurementService"
$c "${g}.measurement.AppMeasurementReceiver"
$c "${g}.measurement.AppMeasurementJobService"
$c "${g}.measurement.PackageMeasurementService"
$c "${g}.measurement.PackageMeasurementTaskService"
$c "${g}.ads.measurement.GmpConversionTrackingBrokerService"
$c "${g}.ads.social.GcmSchedulerWakeupService"
$c "${g}.ads.identifier.service.AdvertisingIdNotificationService"
$c "${g}.ads.identifier.service.AdvertisingIdService"
$c "${g}.feedback.OfflineReportSendTaskService"
$c "${g}.feedback.FeedbackAsyncService"
$c "${g}.ads.jams.NegotiationService"
$c "${g}.ads.cache.CacheBrokerService"
$c "${g}.common.stats.StatsUploadService"
$c "${g}.adid.service.AdIdProviderService"
$c "${g}.adsidentity.service.AdServicesExtDataStorageService"
$c "${g}.nearby.exposurenotification.WakeUpService"
exit
