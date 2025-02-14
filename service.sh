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
echo "Script beginning"
c="pm disable"
gms="com.google.android.gms"
byte="com.bytedance"
disable_tracker() {
    if ! pm list packages | grep -q "^package:$1$"; then
            echo "$1 not found"
            return 0
        fi
    n="${1}/${gms}"
    echo "GMS:"
    $c "${n}.analytics.AnalyticsTaskService"
    $c "${n}.analytics.internal.PlayLogReportingService"
    $c "${n}.analytics.service.AnalyticsService"
    $c "${n}.analytics.AnalyticsReceiver"
    $c "${n}.analytics.CampaignTrackingReceiver"
    $c "${n}.analytics.CampaignTrackingService"
    $c "${n}.measurement.service.MeasurementBrokerService"
    $c "${n}.measurement.PackageMeasurementService"
    $c "${n}.measurement.PackageMeasurementReceiver"
    $c "${n}.measurement.AppMeasurementService"
    $c "${n}.measurement.AppMeasurementReceiver"
    $c "${n}.measurement.AppMeasurementJobService"
    $c "${n}.measurement.PackageMeasurementService"
    $c "${n}.measurement.PackageMeasurementTaskService"
    $c "${n}.ads.AdRequestBrokerService"
    $c "${n}.ads.measurement.GmpConversionTrackingBrokerService"
    $c "${n}.ads.social.GcmSchedulerWakeupService"
    $c "${n}.ads.identifier.service.AdvertisingIdNotificationService"
    $c "${n}.ads.identifier.service.AdvertisingIdService"
    $c "${n}.feedback.OfflineReportSendTaskService"
    $c "${n}.feedback.FeedbackAsyncService"
    $c "${n}.ads.jams.NegotiationService"
    $c "${n}.ads.cache.CacheBrokerService"
    $c "${n}.common.stats.StatsUploadService"
    $c "${n}.adid.service.AdIdProviderService"
    $c "${n}.adsidentity.service.AdServicesExtDataStorageService"
    $c "${n}.nearby.exposurenotification.WakeUpService"
    $c "${n}.ads.AdActivity"

    n="${1}/${byte}.sdk.openadsdk"
    echo "BYTEDANCE:"
    $c "${n}.activity.TTAppOpenAdActivity"
    $c "${n}.activity.TTDelegateActivity"
    $c "${n}.activity.TTFullScreenExpressVideoActivity"
    $c "${n}.activity.TTFullScreenVideoActivity"
    $c "${n}.activity.TTInterstitialActivity"
    $c "${n}.activity.TTInterstitialExpressActivity"
    $c "${n}.activity.TTLandingPageActivity"
    $c "${n}.activity.TTPlayableLandingPageActivity"
    $c "${n}.activity.TTRewardExpressVideoActivity"
    $c "${n}.activity.TTRewardVideoActivity"
    $c "${n}.activity.TTVideoLandingPageLink2Activity"
    $c "${n}.activity.TTWebsiteActivity"
    $c "${n}.multipro.aidl.BinderPoolService"
    n="${1}/${byte}"
    $c "${n}.applog.collector.Collector"

    echo -e "\n\n\n\n\n\n\n"
}
disable_tracker "com.google.android.gms"
disable_tracker "com.google.ar.core"
disable_tracker "com.google.android.google"
disable_tracker "com.google.android.projection.gearhead"
disable_tracker "com.google.android.play.games"
disable_tracker "com.zhiliaoapp.musically"
disable_tracker "com.instagram.android"
disable_tracker "com.facebook.katana"
disable_tracker "com.reddit.frontpage"
disable_tracker "org.telegram.messenger"
disable_tracker "com.ketchapp.rider"
disable_tracker "com.coinbase.android"
disable_tracker "com.alibaba.aliexpresshd"
disable_tracker "com.discord"
disable_tracker "com.ebay.mobile"
disable_tracker "com.oculus.twilight"
disable_tracker "com.kiloo.subwaysurf"
disable_tracker "com.einnovation.temu"
disable_tracker "com.twitter.android"

exit
