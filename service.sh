#!/system/bin/sh
exec > /cache/OOSGMS.txt 2>&1
echo "Script pre execution"

while true; do
    LOCK_STATE=$(dumpsys window | grep "mDreamingLockscreen=" | sed 's/.*mDreamingLockscreen=//')
    #if [ "$LOCK_STATE" = "true" ] || [ "$LOCK_STATE" = "false" ]; then
    if [ "$LOCK_STATE" = "false" ]; then
        break
    fi
    echo "Paused script, waiting for unlock"
    sleep 5
done

sleep 10

echo "Script beginning"

c="su -c pm disable"
un="su -c pm uninstall --user 0"

nline() {
    echo -e "\n\n\n"
}

store_pm_dump() {
    package="$1"
    pm_dump_cache="$(pm dump "$package" 2>/dev/null)"
}

service_exists() {
    echo "$pm_dump_cache" | grep -q "$1"
}

disable_services() {
    package="$1"
    shift
    services="$@"

    if ! pm list packages | cut -d':' -f2 | grep -q "^$package$"; then
        #echo "$package not found"
	#can uncomment, but more overhead
        return 0
    fi

    store_pm_dump "$package"

    for service in $services; do
        if service_exists "$service"; then
            echo "Disabling $service in $package"
            $c "$package/$service"
        #else
            #echo "Service $service not found in $package"
            #can uncomment, but more overhead
        fi
    done

    nline
}

gms="com.google.android.gms"
byte="com.bytedance"

SERVICES="
    $gms.ads.AdActivity
    $gms.ads.AdService
    $gms.analytics.AnalyticsTaskService
    $gms.analytics.AnalyticsService
    $gms.analytics.service.AnalyticsService
    $gms.analytics.AnalyticsReceiver
    $gms.measurement.service.MeasurementBrokerService
    $gms.measurement.AppMeasurementService
    $gms.measurement.AppMeasurementJobService
    $gms.measurement.AppMeasurementReceiver
    $gms.analytics.CampaignTrackingReceiver
    $gms.analytics.CampaignTrackingService
    $byte.sdk.openadsdk.activity.TTAppOpenAdActivity
    $byte.sdk.openadsdk.activity.TTDelegateActivity
    $byte.sdk.openadsdk.activity.TTFullScreenExpressVideoActivity
    $byte.sdk.openadsdk.activity.TTFullScreenVideoActivity
    $byte.sdk.openadsdk.activity.TTInterstitialActivity
    $byte.sdk.openadsdk.activity.TTInterstitialExpressActivity
    $byte.sdk.openadsdk.multipro.aidl.BinderPoolService
    $byte.applog.collector.Collector
"

disable_services "com.facebook.katana" $SERVICES
disable_services "com.instagram.android" $SERVICES
disable_services "com.reddit.frontpage" $SERVICES
disable_services "com.ebay.mobile" $SERVICES
disable_services "com.coinbase.android" $SERVICES
disable_services "com.discord" $SERVICES
disable_services "com.oculus.twilight" $SERVICES
disable_services "com.einnovation.temu" $SERVICES
disable_services "com.twitter.android" $SERVICES
disable_services "com.kiloo.subwaysurf" $SERVICES
disable_services "com.ketchapp.rider" $SERVICES
disable_services "org.telegram.messenger" $SERVICES
disable_services "com.google.ar.core" $SERVICES
disable_services "com.zhiliaoapp.musically" $SERVICES
disable_services "com.twitter.android" $SERVICES
disable_services "com.google.android.play.games" $SERVICES
disable_services "com.google.android.projection.gearhead" $SERVICES
disable_services "com.google.android.googlequicksearchbox" $SERVICES
disable_services "com.google.android.youtube" $SERVICES
disable_services "com.google.android.apps.youtube.music" $SERVICES

$c "$gms/$gms.analytics.AnalyticsTaskService"
$c "$gms/$gms.analytics.AnalyticsService"
$c "$gms/$gms.analytics.internal.PlayLogReportingService"
$c "$gms/$gms.analytics.AnalyticsReceiver"
$c "$gms/$gms.analytics.service.AnalyticsService"
$c "$gms/$gms.analytics.analytics.AnalyticsService"
$c "$gms/$gms.measurement.service.MeasurementBrokerService"
$c "$gms/$gms.measurement.PackageMeasurementService"
$c "$gms/$gms.measurement.PackageMeasurementReceiver"
$c "$gms/$gms.measurement.PackageMeasurementService"
$c "$gms/$gms.measurement.PackageMeasurementTaskService"
$c "$gms/$gms.ads.AdRequestBrokerService"
$c "$gms/$gms.ads.measurement.GmpConversionTrackingBrokerService"
$c "$gms/$gms.ads.social.GcmSchedulerWakeupService"
$c "$gms/$gms.ads.identifier.service.AdvertisingIdNotificationService"
$c "$gms/$gms.ads.identifier.service.AdvertisingIdService"
$c "$gms/$gms.feedback.OfflineReportSendTaskService"
$c "$gms/$gms.feedback.FeedbackAsyncService"
$c "$gms/$gms.ads.jams.NegotiationService"
$c "$gms/$gms.ads.cache.CacheBrokerService"
$c "$gms/$gms.common.stats.StatsUploadService"
$c "$gms/$gms.adid.service.AdIdProviderService"
$c "$gms/$gms.adsidentity.service.AdServicesExtDataStorageService"
$c "$gms/$gms.nearby.exposurenotification.WakeUpService"
$c "$gms/$gms.clearcut.debug.ClearcutDebugDumpService"
$c "$gms/$gms.clearcut.uploader.QosUploaderService"
$c "$gms/$gms.stats.PlatformStatsCollectorService"
$c "$gms/$gms.tron.CollectionService"
$c "$gms/$gms.personalsafety.service.SndDetectionService"
$c "$gms/$gms.semanticlocation.service.SemanticLocationService"


$un com.facebook.services
$un com.facebook.appmanager
$un com.facebook.system
$un com.oplus.powermonitor

exit
