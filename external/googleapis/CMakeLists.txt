# ~~~
# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ~~~

cmake_minimum_required(VERSION 3.5)

# Give application developers a hook to configure the version and hash
# downloaded from GitHub.
set(GOOGLE_CLOUD_CPP_GOOGLEAPIS_URL
    "https://github.com/googleapis/googleapis/archive/abd6b709a5533ba5d0bc435189ffda7f2445cd4b.tar.gz"
)
set(GOOGLE_CLOUD_CPP_GOOGLEAPIS_SHA256
    "c45d0e135ac7ad54c34546404d5338e4980d0b397f093e1e2cb185ec8813430f")

set(GOOGLEAPIS_CPP_SOURCE
    "${CMAKE_BINARY_DIR}/external/googleapis/src/googleapis_download")

set(GOOGLEAPIS_CPP_PROTO_FILES
    "google/api/http.proto"
    "google/api/annotations.proto"
    "google/api/auth.proto"
    "google/api/client.proto"
    "google/api/field_behavior.proto"
    "google/api/label.proto"
    "google/api/launch_stage.proto"
    "google/api/metric.proto"
    "google/api/monitored_resource.proto"
    "google/api/resource.proto"
    "google/devtools/cloudtrace/v2/trace.proto"
    "google/devtools/cloudtrace/v2/tracing.proto"
    "google/type/expr.proto"
    "google/rpc/error_details.proto"
    "google/rpc/status.proto"
    "google/iam/v1/options.proto"
    "google/iam/v1/policy.proto"
    "google/iam/v1/iam_policy.proto"
    "google/longrunning/operations.proto"
    "google/bigtable/admin/v2/bigtable_instance_admin.proto"
    "google/bigtable/admin/v2/bigtable_table_admin.proto"
    "google/bigtable/admin/v2/common.proto"
    "google/bigtable/admin/v2/instance.proto"
    "google/bigtable/admin/v2/table.proto"
    "google/bigtable/v2/bigtable.proto"
    "google/bigtable/v2/data.proto"
    "google/cloud/bigquery/connection/v1beta1/connection.proto"
    "google/cloud/bigquery/datatransfer/v1/datatransfer.proto"
    "google/cloud/bigquery/datatransfer/v1/transfer.proto"
    "google/cloud/bigquery/logging/v1/audit_data.proto"
    "google/cloud/bigquery/storage/v1beta1/arrow.proto"
    "google/cloud/bigquery/storage/v1beta1/avro.proto"
    "google/cloud/bigquery/storage/v1beta1/read_options.proto"
    "google/cloud/bigquery/storage/v1beta1/storage.proto"
    "google/cloud/bigquery/storage/v1beta1/table_reference.proto"
    "google/cloud/bigquery/v2/encryption_config.proto"
    "google/cloud/bigquery/v2/model.proto"
    "google/cloud/bigquery/v2/model_reference.proto"
    "google/cloud/bigquery/v2/standard_sql.proto"
    "google/pubsub/v1/pubsub.proto"
    "google/spanner/admin/database/v1/backup.proto"
    "google/spanner/admin/database/v1/common.proto"
    "google/spanner/admin/database/v1/spanner_database_admin.proto"
    "google/spanner/admin/instance/v1/spanner_instance_admin.proto"
    "google/spanner/v1/keys.proto"
    "google/spanner/v1/mutation.proto"
    "google/spanner/v1/query_plan.proto"
    "google/spanner/v1/result_set.proto"
    "google/spanner/v1/spanner.proto"
    "google/spanner/v1/transaction.proto"
    "google/spanner/v1/type.proto"
    "google/storage/v1/storage.proto"
    "google/storage/v1/storage_resources.proto")

# not required by google-cloud-cpp high level apis
# but we want to generate all grpc and gapic shared libraries during this build.

# obtained from https://github.comgoogleapis/googleapis
# by doing 
# git ls-files google/ |grep proto |egrep -v "(google/ads|google/streetview|google/assistant|google/chromeos|google/home|google/maps|google/example|google/analytics)" 
#
# everything else goes in, including the storage ones already in GOOGLEAPIS_CPP_PROTO_FILES
# make a macro to obtain them instaed
set(GOOGLEAPIS_ADDITIONAL_CPP_PROTO_FILES
google/actions/type/date_range.proto
google/actions/type/datetime_range.proto
google/api/annotations.proto
google/api/auth.proto
google/api/backend.proto
google/api/billing.proto
google/api/client.proto
google/api/config_change.proto
google/api/consumer.proto
google/api/context.proto
google/api/control.proto
google/api/distribution.proto
google/api/documentation.proto
google/api/endpoint.proto
google/api/expr/v1beta1/decl.proto
google/api/expr/v1beta1/eval.proto
google/api/expr/v1beta1/expr.proto
google/api/expr/v1beta1/source.proto
google/api/expr/v1beta1/value.proto
google/api/field_behavior.proto
google/api/http.proto
google/api/httpbody.proto
google/api/label.proto
google/api/launch_stage.proto
google/api/log.proto
google/api/logging.proto
google/api/metric.proto
google/api/monitored_resource.proto
google/api/monitoring.proto
google/api/quota.proto
google/api/resource.proto
google/api/service.proto
google/api/servicecontrol/v1/check_error.proto
google/api/servicecontrol/v1/distribution.proto
google/api/servicecontrol/v1/log_entry.proto
google/api/servicecontrol/v1/metric_value.proto
google/api/servicecontrol/v1/operation.proto
google/api/servicecontrol/v1/quota_controller.proto
google/api/servicecontrol/v1/service_controller.proto
google/api/servicemanagement/v1/resources.proto
google/api/servicemanagement/v1/servicemanager.proto
google/api/source_info.proto
google/api/system_parameter.proto
google/api/usage.proto
google/appengine/legacy/audit_data.proto
google/appengine/logging/v1/request_log.proto
google/appengine/v1/app_yaml.proto
google/appengine/v1/appengine.proto
google/appengine/v1/application.proto
google/appengine/v1/audit_data.proto
google/appengine/v1/deploy.proto
google/appengine/v1/instance.proto
google/appengine/v1/location.proto
google/appengine/v1/operation.proto
google/appengine/v1/service.proto
google/appengine/v1/version.proto
google/bigtable/admin/v2/bigtable_instance_admin.proto
google/bigtable/admin/v2/bigtable_table_admin.proto
google/bigtable/admin/v2/common.proto
google/bigtable/admin/v2/instance.proto
google/bigtable/admin/v2/table.proto
google/bigtable/v2/bigtable.proto
google/bigtable/v2/data.proto
google/bytestream/bytestream.proto
google/cloud/accessapproval/v1/accessapproval.proto
google/cloud/asset/v1/asset_service.proto
google/cloud/asset/v1/assets.proto
google/cloud/audit/audit_log.proto
google/cloud/automl/v1/annotation_payload.proto
google/cloud/automl/v1/annotation_spec.proto
google/cloud/automl/v1/classification.proto
google/cloud/automl/v1/data_items.proto
google/cloud/automl/v1/dataset.proto
google/cloud/automl/v1/detection.proto
google/cloud/automl/v1/geometry.proto
google/cloud/automl/v1/image.proto
google/cloud/automl/v1/io.proto
google/cloud/automl/v1/model.proto
google/cloud/automl/v1/model_evaluation.proto
google/cloud/automl/v1/operations.proto
google/cloud/automl/v1/prediction_service.proto
google/cloud/automl/v1/service.proto
google/cloud/automl/v1/text.proto
google/cloud/automl/v1/text_extraction.proto
google/cloud/automl/v1/text_segment.proto
google/cloud/automl/v1/text_sentiment.proto
google/cloud/automl/v1/translation.proto
google/cloud/bigquery/connection/v1/connection.proto
google/cloud/bigquery/connection/v1beta1/connection.proto
google/cloud/bigquery/datatransfer/v1/datatransfer.proto
google/cloud/bigquery/datatransfer/v1/transfer.proto
google/cloud/bigquery/logging/v1/audit_data.proto
google/cloud/bigquery/reservation/v1/reservation.proto
google/cloud/bigquery/storage/v1/arrow.proto
google/cloud/bigquery/storage/v1/avro.proto
google/cloud/bigquery/storage/v1/storage.proto
google/cloud/bigquery/storage/v1/stream.proto
google/cloud/bigquery/v2/encryption_config.proto
google/cloud/bigquery/v2/model.proto
google/cloud/bigquery/v2/model_reference.proto
google/cloud/bigquery/v2/standard_sql.proto
google/cloud/billing/budgets/v1beta1/budget_model.proto
google/cloud/billing/budgets/v1beta1/budget_service.proto
google/cloud/billing/v1/cloud_billing.proto
google/cloud/billing/v1/cloud_catalog.proto
google/cloud/binaryauthorization/v1beta1/resources.proto
google/cloud/binaryauthorization/v1beta1/service.proto
google/cloud/common_resources.proto
google/cloud/datacatalog/v1/common.proto
google/cloud/datacatalog/v1/datacatalog.proto
google/cloud/datacatalog/v1/gcs_fileset_spec.proto
google/cloud/datacatalog/v1/schema.proto
google/cloud/datacatalog/v1/search.proto
google/cloud/datacatalog/v1/table_spec.proto
google/cloud/datacatalog/v1/tags.proto
google/cloud/datacatalog/v1/timestamps.proto
google/cloud/datalabeling/v1beta1/annotation.proto
google/cloud/datalabeling/v1beta1/annotation_spec_set.proto
google/cloud/datalabeling/v1beta1/data_labeling_service.proto
google/cloud/datalabeling/v1beta1/data_payloads.proto
google/cloud/datalabeling/v1beta1/dataset.proto
google/cloud/datalabeling/v1beta1/evaluation.proto
google/cloud/datalabeling/v1beta1/evaluation_job.proto
google/cloud/datalabeling/v1beta1/human_annotation_config.proto
google/cloud/datalabeling/v1beta1/instruction.proto
google/cloud/datalabeling/v1beta1/operations.proto
google/cloud/dataproc/v1/autoscaling_policies.proto
google/cloud/dataproc/v1/clusters.proto
google/cloud/dataproc/v1/jobs.proto
google/cloud/dataproc/v1/operations.proto
google/cloud/dataproc/v1/shared.proto
google/cloud/dataproc/v1/workflow_templates.proto
google/cloud/dialogflow/v2/agent.proto
google/cloud/dialogflow/v2/audio_config.proto
google/cloud/dialogflow/v2/context.proto
google/cloud/dialogflow/v2/entity_type.proto
google/cloud/dialogflow/v2/environment.proto
google/cloud/dialogflow/v2/intent.proto
google/cloud/dialogflow/v2/session.proto
google/cloud/dialogflow/v2/session_entity_type.proto
google/cloud/dialogflow/v2/validation_result.proto
google/cloud/dialogflow/v2/webhook.proto
google/cloud/documentai/v1beta2/document.proto
google/cloud/documentai/v1beta2/document_understanding.proto
google/cloud/documentai/v1beta2/geometry.proto
google/cloud/functions/v1beta2/functions.proto
google/cloud/functions/v1beta2/operations.proto
google/cloud/gaming/v1beta/common.proto
google/cloud/gaming/v1beta/game_server_clusters.proto
google/cloud/gaming/v1beta/game_server_clusters_service.proto
google/cloud/gaming/v1beta/game_server_configs.proto
google/cloud/gaming/v1beta/game_server_configs_service.proto
google/cloud/gaming/v1beta/game_server_deployments.proto
google/cloud/gaming/v1beta/game_server_deployments_service.proto
google/cloud/gaming/v1beta/realms.proto
google/cloud/gaming/v1beta/realms_service.proto
google/cloud/iot/v1/device_manager.proto
google/cloud/iot/v1/resources.proto
google/cloud/irm/v1alpha2/incidents.proto
google/cloud/irm/v1alpha2/incidents_service.proto
google/cloud/kms/v1/resources.proto
google/cloud/kms/v1/service.proto
google/cloud/language/v1/language_service.proto
google/cloud/location/locations.proto
google/cloud/managedidentities/v1/managed_identities_service.proto
google/cloud/managedidentities/v1/resource.proto
google/cloud/mediatranslation/v1beta1/media_translation.proto
google/cloud/memcache/v1beta2/cloud_memcache.proto
google/cloud/ml/v1/job_service.proto
google/cloud/ml/v1/model_service.proto
google/cloud/ml/v1/operation_metadata.proto
google/cloud/ml/v1/prediction_service.proto
google/cloud/ml/v1/project_service.proto
google/cloud/orgpolicy/v1/orgpolicy.proto
google/cloud/osconfig/agentendpoint/v1/agentendpoint.proto
google/cloud/osconfig/agentendpoint/v1/patch_jobs.proto
google/cloud/osconfig/agentendpoint/v1/tasks.proto
google/cloud/osconfig/v1/osconfig_service.proto
google/cloud/osconfig/v1/patch_deployments.proto
google/cloud/osconfig/v1/patch_jobs.proto
google/cloud/oslogin/common/common.proto
google/cloud/oslogin/v1/oslogin.proto
google/cloud/phishingprotection/v1beta1/phishingprotection.proto
google/cloud/policytroubleshooter/v1/checker.proto
google/cloud/policytroubleshooter/v1/explanations.proto
google/cloud/pubsublite/v1/admin.proto
google/cloud/pubsublite/v1/common.proto
google/cloud/pubsublite/v1/cursor.proto
google/cloud/pubsublite/v1/publisher.proto
google/cloud/pubsublite/v1/subscriber.proto
google/cloud/recaptchaenterprise/v1/recaptchaenterprise.proto
google/cloud/recaptchaenterprise/v1beta1/recaptchaenterprise.proto
google/cloud/recommendationengine/v1beta1/catalog.proto
google/cloud/recommendationengine/v1beta1/catalog_service.proto
google/cloud/recommendationengine/v1beta1/common.proto
google/cloud/recommendationengine/v1beta1/import.proto
google/cloud/recommendationengine/v1beta1/prediction_apikey_registry_service.proto
google/cloud/recommendationengine/v1beta1/prediction_service.proto
google/cloud/recommendationengine/v1beta1/recommendationengine_resources.proto
google/cloud/recommendationengine/v1beta1/user_event.proto
google/cloud/recommendationengine/v1beta1/user_event_service.proto
google/cloud/recommender/logging/v1/action_log.proto
google/cloud/recommender/logging/v1beta1/action_log.proto
google/cloud/recommender/v1/recommendation.proto
google/cloud/recommender/v1/recommender_service.proto
google/cloud/recommender/v1beta1/insight.proto
google/cloud/recommender/v1beta1/recommendation.proto
google/cloud/recommender/v1beta1/recommender_service.proto
google/cloud/redis/v1/cloud_redis.proto
google/cloud/resourcemanager/v2/folders.proto
google/cloud/runtimeconfig/v1beta1/resources.proto
google/cloud/runtimeconfig/v1beta1/runtimeconfig.proto
google/cloud/scheduler/v1/cloudscheduler.proto
google/cloud/scheduler/v1/job.proto
google/cloud/scheduler/v1/target.proto
google/cloud/secretmanager/v1/resources.proto
google/cloud/secretmanager/v1/service.proto
google/cloud/secrets/v1beta1/resources.proto
google/cloud/secrets/v1beta1/service.proto
google/cloud/securitycenter/settings/v1beta1/billing_settings.proto
google/cloud/securitycenter/settings/v1beta1/component_settings.proto
google/cloud/securitycenter/settings/v1beta1/detector.proto
google/cloud/securitycenter/settings/v1beta1/securitycenter_settings_service.proto
google/cloud/securitycenter/settings/v1beta1/settings.proto
google/cloud/securitycenter/settings/v1beta1/sink_settings.proto
google/cloud/securitycenter/v1/asset.proto
google/cloud/securitycenter/v1/finding.proto
google/cloud/securitycenter/v1/notification_config.proto
google/cloud/securitycenter/v1/notification_message.proto
google/cloud/securitycenter/v1/organization_settings.proto
google/cloud/securitycenter/v1/resource.proto
google/cloud/securitycenter/v1/run_asset_discovery_response.proto
google/cloud/securitycenter/v1/security_marks.proto
google/cloud/securitycenter/v1/securitycenter_service.proto
google/cloud/securitycenter/v1/source.proto
google/cloud/servicedirectory/v1beta1/endpoint.proto
google/cloud/servicedirectory/v1beta1/lookup_service.proto
google/cloud/servicedirectory/v1beta1/namespace.proto
google/cloud/servicedirectory/v1beta1/registration_service.proto
google/cloud/servicedirectory/v1beta1/service.proto
google/cloud/speech/v1/cloud_speech.proto
google/cloud/support/common.proto
google/cloud/talent/v4beta1/application.proto
google/cloud/talent/v4beta1/application_service.proto
google/cloud/talent/v4beta1/batch.proto
google/cloud/talent/v4beta1/common.proto
google/cloud/talent/v4beta1/company.proto
google/cloud/talent/v4beta1/company_service.proto
google/cloud/talent/v4beta1/completion_service.proto
google/cloud/talent/v4beta1/event.proto
google/cloud/talent/v4beta1/event_service.proto
google/cloud/talent/v4beta1/filters.proto
google/cloud/talent/v4beta1/histogram.proto
google/cloud/talent/v4beta1/job.proto
google/cloud/talent/v4beta1/job_service.proto
google/cloud/talent/v4beta1/profile.proto
google/cloud/talent/v4beta1/profile_service.proto
google/cloud/talent/v4beta1/tenant.proto
google/cloud/talent/v4beta1/tenant_service.proto
google/cloud/tasks/v2/cloudtasks.proto
google/cloud/tasks/v2/queue.proto
google/cloud/tasks/v2/target.proto
google/cloud/tasks/v2/task.proto
google/cloud/texttospeech/v1/cloud_tts.proto
google/cloud/translate/v3/translation_service.proto
google/cloud/videointelligence/v1/video_intelligence.proto
google/cloud/vision/v1/geometry.proto
google/cloud/vision/v1/image_annotator.proto
google/cloud/vision/v1/product_search.proto
google/cloud/vision/v1/product_search_service.proto
google/cloud/vision/v1/text_annotation.proto
google/cloud/vision/v1/web_detection.proto
google/cloud/webrisk/v1/webrisk.proto
google/cloud/websecurityscanner/v1/crawled_url.proto
google/cloud/websecurityscanner/v1/finding.proto
google/cloud/websecurityscanner/v1/finding_addon.proto
google/cloud/websecurityscanner/v1/finding_type_stats.proto
google/cloud/websecurityscanner/v1/scan_config.proto
google/cloud/websecurityscanner/v1/scan_config_error.proto
google/cloud/websecurityscanner/v1/scan_run.proto
google/cloud/websecurityscanner/v1/scan_run_error_trace.proto
google/cloud/websecurityscanner/v1/scan_run_warning_trace.proto
google/cloud/websecurityscanner/v1/web_security_scanner.proto
google/container/v1/cluster_service.proto
google/datastore/admin/v1/datastore_admin.proto
google/datastore/admin/v1/index.proto
google/datastore/v1/datastore.proto
google/datastore/v1/entity.proto
google/datastore/v1/query.proto
google/devtools/build/v1/build_events.proto
google/devtools/build/v1/build_status.proto
google/devtools/build/v1/publish_build_event.proto
google/devtools/cloudbuild/v1/cloudbuild.proto
google/devtools/clouddebugger/v2/controller.proto
google/devtools/clouddebugger/v2/data.proto
google/devtools/clouddebugger/v2/debugger.proto
google/devtools/clouderrorreporting/v1beta1/common.proto
google/devtools/clouderrorreporting/v1beta1/error_group_service.proto
google/devtools/clouderrorreporting/v1beta1/error_stats_service.proto
google/devtools/clouderrorreporting/v1beta1/report_errors_service.proto
google/devtools/cloudprofiler/v2/profiler.proto
google/devtools/cloudtrace/v1/trace.proto
google/devtools/cloudtrace/v2/trace.proto
google/devtools/cloudtrace/v2/tracing.proto
google/devtools/containeranalysis/v1/containeranalysis.proto
google/devtools/remoteworkers/v1test2/bots.proto
google/devtools/remoteworkers/v1test2/command.proto
google/devtools/remoteworkers/v1test2/worker.proto
google/devtools/resultstore/v2/action.proto
google/devtools/resultstore/v2/common.proto
google/devtools/resultstore/v2/configuration.proto
google/devtools/resultstore/v2/configured_target.proto
google/devtools/resultstore/v2/coverage.proto
google/devtools/resultstore/v2/coverage_summary.proto
google/devtools/resultstore/v2/download_metadata.proto
google/devtools/resultstore/v2/file.proto
google/devtools/resultstore/v2/file_processing_error.proto
google/devtools/resultstore/v2/file_set.proto
google/devtools/resultstore/v2/invocation.proto
google/devtools/resultstore/v2/resultstore_download.proto
google/devtools/resultstore/v2/resultstore_file_download.proto
google/devtools/resultstore/v2/resultstore_upload.proto
google/devtools/resultstore/v2/target.proto
google/devtools/resultstore/v2/test_suite.proto
google/devtools/resultstore/v2/upload_metadata.proto
google/devtools/source/v1/source_context.proto
google/devtools/sourcerepo/v1/sourcerepo.proto
google/firebase/fcm/connection/v1alpha1/connection_api.proto
google/firestore/admin/v1/field.proto
google/firestore/admin/v1/firestore_admin.proto
google/firestore/admin/v1/index.proto
google/firestore/admin/v1/location.proto
google/firestore/admin/v1/operation.proto
google/firestore/v1/common.proto
google/firestore/v1/document.proto
google/firestore/v1/firestore.proto
google/firestore/v1/query.proto
google/firestore/v1/write.proto
google/genomics/v1/annotations.proto
google/genomics/v1/cigar.proto
google/genomics/v1/datasets.proto
google/genomics/v1/operations.proto
google/genomics/v1/position.proto
google/genomics/v1/range.proto
google/genomics/v1/readalignment.proto
google/genomics/v1/readgroup.proto
google/genomics/v1/readgroupset.proto
google/genomics/v1/reads.proto
google/genomics/v1/references.proto
google/genomics/v1/variants.proto
google/genomics/v1alpha2/pipelines.proto
google/geo/type/viewport.proto
google/iam/admin/v1/iam.proto
google/iam/credentials/v1/common.proto
google/iam/credentials/v1/iamcredentials.proto
google/iam/v1/iam_policy.proto
google/iam/v1/logging/audit_data.proto
google/iam/v1/options.proto
google/iam/v1/policy.proto
google/identity/accesscontextmanager/type/device_resources.proto
google/identity/accesscontextmanager/v1/access_level.proto
google/identity/accesscontextmanager/v1/access_policy.proto
google/identity/accesscontextmanager/v1/service_perimeter.proto
google/logging/type/http_request.proto
google/logging/type/log_severity.proto
google/logging/v2/log_entry.proto
google/logging/v2/logging.proto
google/logging/v2/logging_config.proto
google/logging/v2/logging_metrics.proto
google/longrunning/operations.proto
google/monitoring/dashboard/v1/common.proto
google/monitoring/dashboard/v1/dashboard.proto
google/monitoring/dashboard/v1/dashboards_service.proto
google/monitoring/dashboard/v1/drilldowns.proto
google/monitoring/dashboard/v1/layouts.proto
google/monitoring/dashboard/v1/metrics.proto
google/monitoring/dashboard/v1/scorecard.proto
google/monitoring/dashboard/v1/service.proto
google/monitoring/dashboard/v1/text.proto
google/monitoring/dashboard/v1/widget.proto
google/monitoring/dashboard/v1/xychart.proto
google/monitoring/v3/alert.proto
google/monitoring/v3/alert_service.proto
google/monitoring/v3/common.proto
google/monitoring/v3/dropped_labels.proto
google/monitoring/v3/group.proto
google/monitoring/v3/group_service.proto
google/monitoring/v3/metric.proto
google/monitoring/v3/metric_service.proto
google/monitoring/v3/mutation_record.proto
google/monitoring/v3/notification.proto
google/monitoring/v3/notification_service.proto
google/monitoring/v3/service.proto
google/monitoring/v3/service_service.proto
google/monitoring/v3/span_context.proto
google/monitoring/v3/uptime.proto
google/monitoring/v3/uptime_service.proto
google/privacy/dlp/v2/dlp.proto
google/privacy/dlp/v2/storage.proto
google/pubsub/v1/pubsub.proto
google/rpc/code.proto
google/rpc/context/attribute_context.proto
google/rpc/error_details.proto
google/rpc/status.proto
google/search/partnerdataingestion/logging/v1/platformlog.proto
google/spanner/admin/database/v1/backup.proto
google/spanner/admin/database/v1/common.proto
google/spanner/admin/database/v1/spanner_database_admin.proto
google/spanner/admin/instance/v1/spanner_instance_admin.proto
google/spanner/v1/keys.proto
google/spanner/v1/mutation.proto
google/spanner/v1/query_plan.proto
google/spanner/v1/result_set.proto
google/spanner/v1/spanner.proto
google/spanner/v1/transaction.proto
google/spanner/v1/type.proto
google/storage/v1/storage.proto
google/storage/v1/storage_resources.proto
google/storagetransfer/v1/transfer.proto
google/storagetransfer/v1/transfer_types.proto
google/type/calendar_period.proto
google/type/color.proto
google/type/date.proto
google/type/datetime.proto
google/type/dayofweek.proto
google/type/expr.proto
google/type/fraction.proto
google/type/latlng.proto
google/type/money.proto
google/type/month.proto
google/type/postal_address.proto
google/type/quaternion.proto
google/type/timeofday.proto
google/watcher/v1/watch.proto
)


# Always disable clang-tidy for this generated code.
set(CMAKE_CXX_CLANG_TIDY "")

set(GOOGLEAPIS_CPP_BYPRODUCTS)
foreach (proto ${GOOGLEAPIS_CPP_PROTO_FILES})
    list(APPEND GOOGLEAPIS_CPP_BYPRODUCTS "${GOOGLEAPIS_CPP_SOURCE}/${proto}")
endforeach ()

foreach (proto ${GOOGLEAPIS_ADDITIONAL_CPP_PROTO_FILES})
    # FIXME : filter out duplicates ?
    if ( ${proto} IN_LIST "${GOOGLEAPIS_CPP_BYPRODUCTS}" )
    else()
        list(APPEND GOOGLEAPIS_CPP_BYPRODUCTS "${GOOGLEAPIS_CPP_SOURCE}/${proto}")
    endif()
endforeach ()


include(ExternalProject)
ExternalProject_Add(
    googleapis_download
    EXCLUDE_FROM_ALL ON
    PREFIX "${CMAKE_BINARY_DIR}/external/googleapis"
    URL ${GOOGLE_CLOUD_CPP_GOOGLEAPIS_URL}
    URL_HASH SHA256=${GOOGLE_CLOUD_CPP_GOOGLEAPIS_SHA256}
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    INSTALL_COMMAND ""
    BUILD_BYPRODUCTS ${GOOGLEAPIS_CPP_BYPRODUCTS}
    LOG_DOWNLOAD OFF)

find_package(ProtobufWithTargets REQUIRED)
find_package(gRPC REQUIRED)

# Sometimes (this happens often with vcpkg) protobuf is installed in a non-
# standard directory. We need to find out where, and then add that directory to
# the search path for protos.
find_path(PROTO_INCLUDE_DIR google/protobuf/descriptor.proto)
if (PROTO_INCLUDE_DIR)
    list(INSERT PROTOBUF_IMPORT_DIRS 0 "${PROTO_INCLUDE_DIR}")
endif ()

add_library(googleapis_cpp_common_flags INTERFACE)

include(SelectMSVCRuntime)

# Include the functions to compile proto files.
include(CompileProtos)

google_cloud_cpp_add_protos_property()

function (googleapis_cpp_short_name var proto)
    string(REPLACE "google/" "" short_name "${proto}")
    string(REPLACE "/" "_" short_name "${short_name}")
    string(REPLACE ".proto" "_protos" short_name "${short_name}")
    set("${var}"
        "${short_name}"
        PARENT_SCOPE)
endfunction ()

# Create a single source proto library.
#
# * proto: the filename for the proto source.
# * (optional) ARGN: proto libraries the new library depends on.
function (googleapis_cpp_add_library proto)
    googleapis_cpp_short_name(short_name "${proto}")
    google_cloud_cpp_grpcpp_library(
        googleapis_cpp_${short_name} "${GOOGLEAPIS_CPP_SOURCE}/${proto}"
        PROTO_PATH_DIRECTORIES "${GOOGLEAPIS_CPP_SOURCE}"
        "${PROTO_INCLUDE_DIR}")

    googleapis_cpp_set_version_and_alias("${short_name}")

    set(public_deps)
    foreach (dep_short_name ${ARGN})
        list(APPEND public_deps "googleapis-c++::${dep_short_name}")
    endforeach ()
    list(LENGTH public_deps public_deps_length)
    if (public_deps_length EQUAL 0)
        target_link_libraries("googleapis_cpp_${short_name}"
                              PRIVATE googleapis_cpp_common_flags)
    else ()
        target_link_libraries(
            "googleapis_cpp_${short_name}"
            PUBLIC ${public_deps}
            PRIVATE googleapis_cpp_common_flags)
    endif ()
endfunction ()

add_custom_target(google-cloud-cpp-protos)

function (googleapis_cpp_set_version_and_alias short_name)
    add_dependencies(google-cloud-cpp-protos "googleapis_cpp_${short_name}")
    add_dependencies("googleapis_cpp_${short_name}" googleapis_download)
    set_target_properties(
        "googleapis_cpp_${short_name}"
        PROPERTIES VERSION "${GOOGLE_CLOUD_CPP_VERSION}"
                   SOVERSION ${GOOGLE_CLOUD_CPP_VERSION_MAJOR})

    get_target_property( _target_type "googleapis_cpp_${short_name}" TYPE )
    if ( _target_type STREQUAL SHARED_LIBRARY )
       target_link_options( "googleapis_cpp_${short_name}" PRIVATE "-Wl,--no-undefined" "-Werror" )
    endif() 
    unset( _target_type)

    add_library("googleapis-c++::${short_name}" ALIAS
                "googleapis_cpp_${short_name}")
endfunction ()

# Let's restore some alphabetic sanity in here...

googleapis_cpp_add_library("google/actions/type/date_range.proto" type_date_protos)
googleapis_cpp_add_library("google/actions/type/datetime_range.proto" type_datetime_protos)


# which of these are of public visibility ?
googleapis_cpp_add_library("google/api/annotations.proto" api_http_protos)
googleapis_cpp_add_library("google/api/auth.proto" api_annotations_protos)
googleapis_cpp_add_library("google/api/backend.proto")
googleapis_cpp_add_library("google/api/billing.proto" api_annotations_protos api_metric_protos)
googleapis_cpp_add_library("google/api/client.proto")
googleapis_cpp_add_library("google/api/config_change.proto")
googleapis_cpp_add_library("google/api/consumer.proto")
googleapis_cpp_add_library("google/api/context.proto")
googleapis_cpp_add_library("google/api/control.proto")
googleapis_cpp_add_library("google/api/distribution.proto" api_annotations_protos)
googleapis_cpp_add_library("google/api/documentation.proto")
googleapis_cpp_add_library("google/api/endpoint.proto" api_annotations_protos)
googleapis_cpp_add_library("google/api/field_behavior.proto")
googleapis_cpp_add_library("google/api/http.proto")
googleapis_cpp_add_library("google/api/httpbody.proto")
googleapis_cpp_add_library("google/api/label.proto")
googleapis_cpp_add_library("google/api/launch_stage.proto")
googleapis_cpp_add_library("google/api/log.proto" api_label_protos)
googleapis_cpp_add_library("google/api/logging.proto" api_annotations_protos api_label_protos)
googleapis_cpp_add_library("google/api/metric.proto" api_launch_stage_protos api_label_protos)
googleapis_cpp_add_library("google/api/monitored_resource.proto"  api_launch_stage_protos api_label_protos)
googleapis_cpp_add_library("google/api/monitoring.proto" api_annotations_protos)
googleapis_cpp_add_library("google/api/quota.proto" api_annotations_protos)
googleapis_cpp_add_library("google/api/resource.proto")
googleapis_cpp_add_library("google/api/source_info.proto")
googleapis_cpp_add_library("google/api/system_parameter.proto")
googleapis_cpp_add_library("google/api/usage.proto" api_annotations_protos)

google_cloud_cpp_grpcpp_library(
  googleapis_cpp_api_service_protos
  "${GOOGLEAPIS_CPP_SOURCE}/google/api/service.proto"
    PROTO_PATH_DIRECTORIES
    "${GOOGLEAPIS_CPP_SOURCE}"
    "${PROTO_INCLUDE_DIR}")
googleapis_cpp_set_version_and_alias(api_service_protos)
target_link_libraries(
    googleapis_cpp_api_service_protos
    PUBLIC  googleapis-c++::api_annotations_protos
            googleapis-c++::api_auth_protos
            googleapis-c++::api_backend_protos
            googleapis-c++::api_billing_protos
            googleapis-c++::api_context_protos
            googleapis-c++::api_control_protos
            googleapis-c++::api_documentation_protos
            googleapis-c++::api_endpoint_protos
            googleapis-c++::api_http_protos
            googleapis-c++::api_label_protos
            googleapis-c++::api_log_protos
            googleapis-c++::api_logging_protos
            googleapis-c++::api_metric_protos
            googleapis-c++::api_monitored_resource_protos
            googleapis-c++::api_monitoring_protos
            googleapis-c++::api_quota_protos
            googleapis-c++::api_resource_protos
            googleapis-c++::api_source_info_protos
            googleapis-c++::api_system_parameter_protos
            googleapis-c++::api_usage_protos
    PRIVATE googleapis_cpp_common_flags)



#make a function for multiproto libraries...
# api_expr_v1beta1 ?

google_cloud_cpp_grpcpp_library(
    googleapis_cpp_api_expr_v1beta1_protos
    "${GOOGLEAPIS_CPP_SOURCE}/google/api/expr/v1beta1/decl.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/api/expr/v1beta1/eval.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/api/expr/v1beta1/expr.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/api/expr/v1beta1/source.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/api/expr/v1beta1/value.proto"
    PROTO_PATH_DIRECTORIES
    "${GOOGLEAPIS_CPP_SOURCE}"
    "${PROTO_INCLUDE_DIR}")
googleapis_cpp_set_version_and_alias(api_expr_v1beta1_protos)
target_link_libraries(
    googleapis_cpp_api_expr_v1beta1_protos
    PUBLIC  googleapis-c++::rpc_status_protos
    PRIVATE googleapis_cpp_common_flags)

# api_servicecontrol_v1 
google_cloud_cpp_grpcpp_library(
    googleapis_cpp_api_servicecontrol_v1_protos
    "${GOOGLEAPIS_CPP_SOURCE}/google/api/servicecontrol/v1/check_error.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/api/servicecontrol/v1/distribution.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/api/servicecontrol/v1/log_entry.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/api/servicecontrol/v1/metric_value.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/api/servicecontrol/v1/operation.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/api/servicecontrol/v1/quota_controller.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/api/servicecontrol/v1/service_controller.proto"
    PROTO_PATH_DIRECTORIES
    "${GOOGLEAPIS_CPP_SOURCE}"
    "${PROTO_INCLUDE_DIR}")
googleapis_cpp_set_version_and_alias(api_servicecontrol_v1_protos)
target_link_libraries(
    googleapis_cpp_api_servicecontrol_v1_protos
    PUBLIC googleapis-c++::api_annotations_protos
           googleapis-c++::api_client_protos
           googleapis-c++::logging_type_protos
	   googleapis-c++::rpc_status_protos
	   googleapis-c++::type_money_protos
    PRIVATE googleapis_cpp_common_flags)


# api_servicemanagement_v1
google_cloud_cpp_grpcpp_library(
    googleapis_cpp_api_servicemanagement_v1_protos
    "${GOOGLEAPIS_CPP_SOURCE}/google/api/servicemanagement/v1/resources.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/api/servicemanagement/v1/servicemanager.proto"
    PROTO_PATH_DIRECTORIES
    "${GOOGLEAPIS_CPP_SOURCE}"
    "${PROTO_INCLUDE_DIR}")
googleapis_cpp_set_version_and_alias(api_servicemanagement_v1_protos)
target_link_libraries(
    googleapis_cpp_api_servicemanagement_v1_protos
    PUBLIC  googleapis-c++::api_annotations_protos
            googleapis-c++::api_client_protos
            googleapis-c++::api_config_change_protos
            googleapis-c++::api_field_behavior_protos
            googleapis-c++::api_metric_protos
            googleapis-c++::api_quota_protos
            googleapis-c++::api_service_protos
            googleapis-c++::longrunning_operations_protos
            googleapis-c++::rpc_status_protos
    PRIVATE googleapis_cpp_common_flags)

googleapis_cpp_add_library("google/bytestream/bytestream.proto" api_annotations_protos)

googleapis_cpp_add_library("google/rpc/code.proto")
googleapis_cpp_add_library("google/rpc/error_details.proto")
googleapis_cpp_add_library("google/rpc/status.proto" rpc_error_details_protos)
googleapis_cpp_add_library("google/rpc/context/attribute_context.proto")

googleapis_cpp_add_library("google/iam/v1/options.proto" api_annotations_protos)
googleapis_cpp_add_library("google/iam/v1/policy.proto" api_annotations_protos
                           type_expr_protos)

googleapis_cpp_add_library(
    "google/iam/v1/iam_policy.proto"
    api_annotations_protos
    api_client_protos
    api_field_behavior_protos
    api_resource_protos
    iam_v1_options_protos
    iam_v1_policy_protos)

googleapis_cpp_add_library(
  "google/iam/admin/v1/iam.proto"
  api_annotations_protos
  api_client_protos
  api_field_behavior_protos
  api_resource_protos
  iam_v1_iam_policy_protos
  iam_v1_policy_protos
)

googleapis_cpp_add_library(
    "google/longrunning/operations.proto" api_annotations_protos
    api_client_protos rpc_status_protos)

googleapis_cpp_add_library(
    "google/devtools/cloudtrace/v2/trace.proto" api_annotations_protos
    api_field_behavior_protos api_resource_protos rpc_status_protos)
googleapis_cpp_add_library(
    "google/devtools/cloudtrace/v2/tracing.proto"
    devtools_cloudtrace_v2_trace_protos api_annotations_protos
    api_client_protos api_field_behavior_protos rpc_status_protos)

google_cloud_cpp_grpcpp_library(
    googleapis_cpp_cloud_bigquery_protos
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/bigquery/connection/v1/connection.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/bigquery/connection/v1beta1/connection.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/bigquery/datatransfer/v1/datatransfer.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/bigquery/datatransfer/v1/transfer.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/bigquery/logging/v1/audit_data.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/bigquery/storage/v1beta1/arrow.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/bigquery/storage/v1beta1/avro.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/bigquery/storage/v1beta1/read_options.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/bigquery/storage/v1beta1/storage.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/bigquery/storage/v1beta1/table_reference.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/bigquery/v2/encryption_config.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/bigquery/v2/model.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/bigquery/v2/model_reference.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/bigquery/v2/standard_sql.proto"
    PROTO_PATH_DIRECTORIES
    "${GOOGLEAPIS_CPP_SOURCE}"
    "${PROTO_INCLUDE_DIR}")
googleapis_cpp_set_version_and_alias(cloud_bigquery_protos)
target_link_libraries(
    googleapis_cpp_cloud_bigquery_protos
    PUBLIC googleapis-c++::api_annotations_protos
           googleapis-c++::api_client_protos
           googleapis-c++::api_field_behavior_protos
           googleapis-c++::api_resource_protos
           googleapis-c++::iam_v1_iam_policy_protos
           googleapis-c++::iam_v1_policy_protos
           googleapis-c++::rpc_status_protos
           googleapis-c++::api_http_protos
    PRIVATE googleapis_cpp_common_flags)

google_cloud_cpp_grpcpp_library(
    googleapis_cpp_bigtable_protos
    "${GOOGLEAPIS_CPP_SOURCE}/google/bigtable/admin/v2/bigtable_instance_admin.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/bigtable/admin/v2/bigtable_table_admin.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/bigtable/admin/v2/common.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/bigtable/admin/v2/instance.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/bigtable/admin/v2/table.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/bigtable/v2/bigtable.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/bigtable/v2/data.proto"
    PROTO_PATH_DIRECTORIES
    "${GOOGLEAPIS_CPP_SOURCE}"
    "${PROTO_INCLUDE_DIR}")
googleapis_cpp_set_version_and_alias(bigtable_protos)
target_link_libraries(
    googleapis_cpp_bigtable_protos
    PUBLIC googleapis-c++::api_annotations_protos
           googleapis-c++::api_client_protos
           googleapis-c++::api_field_behavior_protos
           googleapis-c++::api_resource_protos
           googleapis-c++::iam_v1_iam_policy_protos
           googleapis-c++::iam_v1_policy_protos
           googleapis-c++::longrunning_operations_protos
           googleapis-c++::rpc_status_protos
           googleapis-c++::api_auth_protos
    PRIVATE googleapis_cpp_common_flags)

google_cloud_cpp_grpcpp_library(
    googleapis_cpp_pubsub_protos
    "${GOOGLEAPIS_CPP_SOURCE}/google/pubsub/v1/pubsub.proto"
    PROTO_PATH_DIRECTORIES "${GOOGLEAPIS_CPP_SOURCE}" "${PROTO_INCLUDE_DIR}")
googleapis_cpp_set_version_and_alias(pubsub_protos)
target_link_libraries(
    googleapis_cpp_pubsub_protos
    PUBLIC googleapis-c++::api_annotations_protos
           googleapis-c++::api_client_protos
           googleapis-c++::api_field_behavior_protos
           googleapis-c++::api_resource_protos
    PRIVATE googleapis_cpp_common_flags)

google_cloud_cpp_grpcpp_library(
    googleapis_cpp_spanner_protos
    "${GOOGLEAPIS_CPP_SOURCE}/google/spanner/admin/database/v1/backup.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/spanner/admin/database/v1/common.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/spanner/admin/database/v1/spanner_database_admin.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/spanner/admin/instance/v1/spanner_instance_admin.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/spanner/v1/keys.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/spanner/v1/mutation.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/spanner/v1/query_plan.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/spanner/v1/result_set.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/spanner/v1/spanner.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/spanner/v1/transaction.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/spanner/v1/type.proto"
    PROTO_PATH_DIRECTORIES
    "${GOOGLEAPIS_CPP_SOURCE}"
    "${PROTO_INCLUDE_DIR}")
googleapis_cpp_set_version_and_alias(spanner_protos)
target_link_libraries(
    googleapis_cpp_spanner_protos
    PUBLIC googleapis-c++::api_annotations_protos
           googleapis-c++::api_client_protos
           googleapis-c++::api_field_behavior_protos
           googleapis-c++::api_resource_protos
           googleapis-c++::iam_v1_iam_policy_protos
           googleapis-c++::iam_v1_policy_protos
           googleapis-c++::longrunning_operations_protos
           googleapis-c++::rpc_status_protos
    PRIVATE googleapis_cpp_common_flags)

google_cloud_cpp_grpcpp_library(
    googleapis_cpp_storage_protos
    "${GOOGLEAPIS_CPP_SOURCE}/google/storage/v1/storage.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/storage/v1/storage_resources.proto"
    PROTO_PATH_DIRECTORIES
    "${GOOGLEAPIS_CPP_SOURCE}"
    "${PROTO_INCLUDE_DIR}")
googleapis_cpp_set_version_and_alias(storage_protos)
target_link_libraries(
    googleapis_cpp_storage_protos
    PUBLIC googleapis-c++::api_annotations_protos
           googleapis-c++::api_client_protos
           googleapis-c++::api_field_behavior_protos
           googleapis-c++::iam_v1_iam_policy_protos
           googleapis-c++::iam_v1_policy_protos
    PRIVATE googleapis_cpp_common_flags)

google_cloud_cpp_grpcpp_library(
    googleapis_cpp_storagetransfer_v1_protos
    "${GOOGLEAPIS_CPP_SOURCE}/google/storagetransfer/v1/transfer.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/storagetransfer/v1/transfer_types.proto"
    PROTO_PATH_DIRECTORIES
    "${GOOGLEAPIS_CPP_SOURCE}"
    "${PROTO_INCLUDE_DIR}")
googleapis_cpp_set_version_and_alias(storagetransfer_v1_protos)
target_link_libraries(
    googleapis_cpp_storagetransfer_v1_protos
    PUBLIC googleapis-c++::api_annotations_protos
           googleapis-c++::rpc_code_protos
           googleapis-c++::type_date_protos
           googleapis-c++::type_timeofday_protos
    PRIVATE googleapis_cpp_common_flags)

googleapis_cpp_add_library(
  "google/cloud/audit/audit_log.proto"
  api_annotations_protos
  api_client_protos
  api_label_protos
  longrunning_operations_protos
  rpc_status_protos
)

google_cloud_cpp_grpcpp_library(
  googleapis_cpp_cloud_automl_v1_protos
  "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/automl/v1/annotation_payload.proto"
  "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/automl/v1/annotation_spec.proto"
  "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/automl/v1/classification.proto"
  "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/automl/v1/data_items.proto"
  "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/automl/v1/dataset.proto"
  "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/automl/v1/detection.proto"
  "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/automl/v1/geometry.proto"
  "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/automl/v1/image.proto"
  "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/automl/v1/io.proto"
  "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/automl/v1/model.proto"
  "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/automl/v1/model_evaluation.proto"
  "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/automl/v1/operations.proto"
  "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/automl/v1/prediction_service.proto"
  "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/automl/v1/service.proto"
  "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/automl/v1/text.proto"
  "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/automl/v1/text_extraction.proto"
  "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/automl/v1/text_segment.proto"
  "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/automl/v1/text_sentiment.proto"
  "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/automl/v1/translation.proto"
  PROTO_PATH_DIRECTORIES
  "${GOOGLEAPIS_CPP_SOURCE}"
  "${PROTO_INCLUDE_DIR}"
)
googleapis_cpp_set_version_and_alias(cloud_automl_v1_protos)
target_link_libraries(googleapis_cpp_cloud_automl_v1_protos
                      PUBLIC googleapis-c++::api_annotations_protos
		             googleapis-c++::api_client_protos
		             googleapis-c++::api_field_behavior_protos
                             googleapis-c++::api_resource_protos
                             googleapis-c++::longrunning_operations_protos
                             googleapis-c++::rpc_status_protos
		      PRIVATE googleapis_cpp_common_flags )

google_cloud_cpp_grpcpp_library(
    googleapis_cpp_cloud_datalabeling_v1beta1_protos
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/datalabeling/v1beta1/annotation.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/datalabeling/v1beta1/annotation_spec_set.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/datalabeling/v1beta1/data_labeling_service.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/datalabeling/v1beta1/dataset.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/datalabeling/v1beta1/data_payloads.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/datalabeling/v1beta1/evaluation.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/datalabeling/v1beta1/evaluation_job.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/datalabeling/v1beta1/human_annotation_config.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/datalabeling/v1beta1/instruction.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/datalabeling/v1beta1/operations.proto"
    PROTO_PATH_DIRECTORIES
    "${GOOGLEAPIS_CPP_SOURCE}"
    "${PROTO_INCLUDE_DIR}")  
googleapis_cpp_set_version_and_alias(cloud_datalabeling_v1beta1_protos)
target_link_libraries(googleapis_cpp_cloud_datalabeling_v1beta1_protos
                      PUBLIC googleapis-c++::api_annotations_protos
                             googleapis-c++::api_client_protos
                             googleapis-c++::api_field_behavior_protos
			     googleapis-c++::api_resource_protos
                             googleapis-c++::longrunning_operations_protos
                             googleapis-c++::rpc_status_protos
		      PRIVATE googleapis_cpp_common_flags )

google_cloud_cpp_grpcpp_library(
    googleapis_cpp_cloud_kms_v1_protos
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/kms/v1/resources.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/kms/v1/service.proto"
    PROTO_PATH_DIRECTORIES
    "${GOOGLEAPIS_CPP_SOURCE}"
    "${PROTO_INCLUDE_DIR}")  
googleapis_cpp_set_version_and_alias(cloud_kms_v1_protos)
target_link_libraries(googleapis_cpp_cloud_kms_v1_protos
                      PUBLIC googleapis-c++::api_annotations_protos
		             googleapis-c++::api_client_protos
		             googleapis-c++::api_field_behavior_protos
			     googleapis-c++::api_resource_protos
		      PRIVATE googleapis_cpp_common_flags )

google_cloud_cpp_grpcpp_library(
    googleapis_cpp_cloud_language_v1_protos
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/language/v1/language_service.proto"
    PROTO_PATH_DIRECTORIES
    "${GOOGLEAPIS_CPP_SOURCE}"
    "${PROTO_INCLUDE_DIR}")  
googleapis_cpp_set_version_and_alias(cloud_language_v1_protos)
target_link_libraries(googleapis_cpp_cloud_language_v1_protos
                      PUBLIC googleapis-c++::api_annotations_protos
                             googleapis-c++::api_client_protos
                             googleapis-c++::api_field_behavior_protos
		      PRIVATE googleapis_cpp_common_flags )

google_cloud_cpp_grpcpp_library(
    googleapis_cpp_cloud_location_protos
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/location/locations.proto"
    PROTO_PATH_DIRECTORIES
    "${GOOGLEAPIS_CPP_SOURCE}"
    "${PROTO_INCLUDE_DIR}")  
googleapis_cpp_set_version_and_alias(cloud_location_protos)
target_link_libraries(googleapis_cpp_cloud_location_protos
                      PUBLIC googleapis-c++::api_annotations_protos
		      PRIVATE googleapis_cpp_common_flags )

google_cloud_cpp_grpcpp_library(
    googleapis_cpp_cloud_ml_v1_protos
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/ml/v1/job_service.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/ml/v1/model_service.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/ml/v1/operation_metadata.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/ml/v1/prediction_service.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/ml/v1/project_service.proto"
    PROTO_PATH_DIRECTORIES
    "${GOOGLEAPIS_CPP_SOURCE}"
    "${PROTO_INCLUDE_DIR}")  
googleapis_cpp_set_version_and_alias(cloud_ml_v1_protos)
target_link_libraries(googleapis_cpp_cloud_ml_v1_protos
                      PUBLIC googleapis-c++::api_annotations_protos
                             googleapis-c++::api_auth_protos
                             googleapis-c++::api_httpbody_protos
                             googleapis-c++::longrunning_operations_protos		      
		      PRIVATE googleapis_cpp_common_flags )

google_cloud_cpp_grpcpp_library(
    googleapis_cpp_cloud_oslogin_v1_protos
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/oslogin/common/common.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/oslogin/v1/oslogin.proto"
    PROTO_PATH_DIRECTORIES
    "${GOOGLEAPIS_CPP_SOURCE}"
    "${PROTO_INCLUDE_DIR}")  
googleapis_cpp_set_version_and_alias(cloud_oslogin_v1_protos)
target_link_libraries(googleapis_cpp_cloud_oslogin_v1_protos
                      PUBLIC googleapis-c++::api_annotations_protos
		             googleapis-c++::api_client_protos
		             googleapis-c++::api_field_behavior_protos
		             googleapis-c++::api_resource_protos
		      PRIVATE googleapis_cpp_common_flags )

google_cloud_cpp_grpcpp_library(
    googleapis_cpp_cloud_redis_v1_protos
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/redis/v1/cloud_redis.proto"
    PROTO_PATH_DIRECTORIES
    "${GOOGLEAPIS_CPP_SOURCE}"
    "${PROTO_INCLUDE_DIR}")  
googleapis_cpp_set_version_and_alias(cloud_redis_v1_protos)
target_link_libraries(googleapis_cpp_cloud_redis_v1_protos
                      PUBLIC googleapis-c++::api_annotations_protos
		             googleapis-c++::api_client_protos
		             googleapis-c++::api_field_behavior_protos
		             googleapis-c++::api_resource_protos
		             googleapis-c++::longrunning_operations_protos
		      PRIVATE googleapis_cpp_common_flags )

google_cloud_cpp_grpcpp_library(
    googleapis_cpp_cloud_runtimeconfig_v1beta1_protos
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/runtimeconfig/v1beta1/resources.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/runtimeconfig/v1beta1/runtimeconfig.proto"
    PROTO_PATH_DIRECTORIES
    "${GOOGLEAPIS_CPP_SOURCE}"
    "${PROTO_INCLUDE_DIR}")  
googleapis_cpp_set_version_and_alias(cloud_runtimeconfig_v1beta1_protos)
target_link_libraries(googleapis_cpp_cloud_runtimeconfig_v1beta1_protos
                      PUBLIC googleapis-c++::api_annotations_protos
		             googleapis-c++::longrunning_operations_protos
		             googleapis-c++::rpc_status_protos
		      PRIVATE googleapis_cpp_common_flags )

google_cloud_cpp_grpcpp_library(
    googleapis_cpp_cloud_scheduler_v1_protos
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/scheduler/v1/cloudscheduler.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/scheduler/v1/job.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/scheduler/v1/target.proto"
    PROTO_PATH_DIRECTORIES
    "${GOOGLEAPIS_CPP_SOURCE}"
    "${PROTO_INCLUDE_DIR}")  
googleapis_cpp_set_version_and_alias(cloud_scheduler_v1_protos)
target_link_libraries(googleapis_cpp_cloud_scheduler_v1_protos
                      PUBLIC googleapis-c++::api_annotations_protos
		             googleapis-c++::api_client_protos
		             googleapis-c++::api_field_behavior_protos
		             googleapis-c++::api_resource_protos
			     googleapis-c++::rpc_status_protos
		      PRIVATE googleapis_cpp_common_flags )

google_cloud_cpp_grpcpp_library(
    googleapis_cpp_cloud_speech_v1_protos
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/speech/v1/cloud_speech.proto"
    PROTO_PATH_DIRECTORIES
    "${GOOGLEAPIS_CPP_SOURCE}"
    "${PROTO_INCLUDE_DIR}")  
googleapis_cpp_set_version_and_alias(cloud_speech_v1_protos)
target_link_libraries(googleapis_cpp_cloud_speech_v1_protos
                      PUBLIC googleapis-c++::api_annotations_protos
		             googleapis-c++::api_field_behavior_protos
		             googleapis-c++::longrunning_operations_protos
			     googleapis-c++::rpc_status_protos
		      PRIVATE googleapis_cpp_common_flags )

google_cloud_cpp_grpcpp_library(
    googleapis_cpp_cloud_tasks_v2_protos
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/tasks/v2/cloudtasks.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/tasks/v2/queue.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/tasks/v2/target.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/tasks/v2/task.proto"
    PROTO_PATH_DIRECTORIES
    "${GOOGLEAPIS_CPP_SOURCE}"
    "${PROTO_INCLUDE_DIR}")  
googleapis_cpp_set_version_and_alias(cloud_tasks_v2_protos)
target_link_libraries(googleapis_cpp_cloud_tasks_v2_protos
                      PUBLIC googleapis-c++::api_annotations_protos
		             googleapis-c++::api_resource_protos
		             googleapis-c++::iam_v1_iam_policy_protos
		             googleapis-c++::iam_v1_policy_protos
			     googleapis-c++::rpc_code_protos
			     googleapis-c++::rpc_status_protos
		      PRIVATE googleapis_cpp_common_flags )

google_cloud_cpp_grpcpp_library(
    googleapis_cpp_cloud_texttospeech_v1_protos
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/texttospeech/v1/cloud_tts.proto"
    PROTO_PATH_DIRECTORIES
    "${GOOGLEAPIS_CPP_SOURCE}"
    "${PROTO_INCLUDE_DIR}")  
googleapis_cpp_set_version_and_alias(cloud_texttospeech_v1_protos)
target_link_libraries(googleapis_cpp_cloud_texttospeech_v1_protos
                      PUBLIC googleapis-c++::api_annotations_protos
		             googleapis-c++::api_client_protos
			     googleapis-c++::api_field_behavior_protos
		      PRIVATE googleapis_cpp_common_flags )

google_cloud_cpp_grpcpp_library(
    googleapis_cpp_cloud_translate_v3_protos
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/translate/v3/translation_service.proto"
    PROTO_PATH_DIRECTORIES
    "${GOOGLEAPIS_CPP_SOURCE}"
    "${PROTO_INCLUDE_DIR}")  
googleapis_cpp_set_version_and_alias(cloud_translate_v3_protos)
target_link_libraries(googleapis_cpp_cloud_translate_v3_protos
                      PUBLIC googleapis-c++::api_annotations_protos
		             googleapis-c++::api_client_protos
		             googleapis-c++::api_field_behavior_protos
		             googleapis-c++::api_resource_protos
		             googleapis-c++::longrunning_operations_protos
		      PRIVATE googleapis_cpp_common_flags )

google_cloud_cpp_grpcpp_library(
    googleapis_cpp_cloud_videointelligence_v1_protos
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/videointelligence/v1/video_intelligence.proto"
    PROTO_PATH_DIRECTORIES
    "${GOOGLEAPIS_CPP_SOURCE}"
    "${PROTO_INCLUDE_DIR}")  
googleapis_cpp_set_version_and_alias(cloud_videointelligence_v1_protos)
target_link_libraries(googleapis_cpp_cloud_videointelligence_v1_protos
                      PUBLIC googleapis-c++::api_annotations_protos
		             googleapis-c++::api_client_protos
		             googleapis-c++::api_field_behavior_protos
		             googleapis-c++::longrunning_operations_protos
		             googleapis-c++::rpc_status_protos
		      PRIVATE googleapis_cpp_common_flags )

google_cloud_cpp_grpcpp_library(
    googleapis_cpp_cloud_vision_v1_protos
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/vision/v1/geometry.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/vision/v1/image_annotator.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/vision/v1/product_search.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/vision/v1/product_search_service.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/vision/v1/text_annotation.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/cloud/vision/v1/web_detection.proto"
    PROTO_PATH_DIRECTORIES
    "${GOOGLEAPIS_CPP_SOURCE}"
    "${PROTO_INCLUDE_DIR}")  
googleapis_cpp_set_version_and_alias(cloud_vision_v1_protos)
target_link_libraries(googleapis_cpp_cloud_vision_v1_protos
                      PUBLIC googleapis-c++::api_annotations_protos
		             googleapis-c++::api_client_protos
		             googleapis-c++::api_field_behavior_protos
		             googleapis-c++::api_resource_protos
		             googleapis-c++::longrunning_operations_protos
		             googleapis-c++::rpc_status_protos
			     googleapis-c++::type_color_protos
			     googleapis-c++::type_latlng_protos
		      PRIVATE googleapis_cpp_common_flags )

google_cloud_cpp_grpcpp_library(
    googleapis_cpp_datastore_admin_v1_protos
    "${GOOGLEAPIS_CPP_SOURCE}/google/datastore/admin/v1/datastore_admin.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/datastore/admin/v1/index.proto"
    PROTO_PATH_DIRECTORIES
    "${GOOGLEAPIS_CPP_SOURCE}"
    "${PROTO_INCLUDE_DIR}")  
googleapis_cpp_set_version_and_alias(datastore_admin_v1_protos)
target_link_libraries(googleapis_cpp_datastore_admin_v1_protos
                      PUBLIC googleapis-c++::api_annotations_protos
                             googleapis-c++::api_client_protos
                             googleapis-c++::api_field_behavior_protos
                             googleapis-c++::longrunning_operations_protos
		      PRIVATE googleapis_cpp_common_flags )

google_cloud_cpp_grpcpp_library(
    googleapis_cpp_datastore_v1_protos
    "${GOOGLEAPIS_CPP_SOURCE}/google/datastore/v1/datastore.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/datastore/v1/entity.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/datastore/v1/query.proto"
    PROTO_PATH_DIRECTORIES
    "${GOOGLEAPIS_CPP_SOURCE}"
    "${PROTO_INCLUDE_DIR}")  
googleapis_cpp_set_version_and_alias(datastore_v1_protos)
target_link_libraries(googleapis_cpp_datastore_v1_protos
                      PUBLIC googleapis-c++::api_annotations_protos
                             googleapis-c++::api_client_protos
                             googleapis-c++::api_field_behavior_protos
                             googleapis-c++::type_latlng_protos
		      PRIVATE googleapis_cpp_common_flags )


google_cloud_cpp_grpcpp_library(
    googleapis_cpp_firestore_admin_v1_protos
    "${GOOGLEAPIS_CPP_SOURCE}/google/firestore/admin/v1/field.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/firestore/admin/v1/firestore_admin.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/firestore/admin/v1/index.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/firestore/admin/v1/location.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/firestore/admin/v1/operation.proto"
    PROTO_PATH_DIRECTORIES
    "${GOOGLEAPIS_CPP_SOURCE}"
    "${PROTO_INCLUDE_DIR}")  
googleapis_cpp_set_version_and_alias(firestore_admin_v1_protos)
target_link_libraries(googleapis_cpp_firestore_admin_v1_protos
                      PUBLIC googleapis-c++::api_annotations_protos
                             googleapis-c++::api_client_protos
                             googleapis-c++::api_field_behavior_protos
                             googleapis-c++::api_resource_protos
                             googleapis-c++::longrunning_operations_protos
			     googleapis-c++::type_latlng_protos
		      PRIVATE googleapis_cpp_common_flags )

google_cloud_cpp_grpcpp_library(
    googleapis_cpp_firestore_v1_protos
    "${GOOGLEAPIS_CPP_SOURCE}/google/firestore/v1/common.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/firestore/v1/document.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/firestore/v1/firestore.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/firestore/v1/query.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/firestore/v1/write.proto"
    PROTO_PATH_DIRECTORIES
    "${GOOGLEAPIS_CPP_SOURCE}"
    "${PROTO_INCLUDE_DIR}")  
googleapis_cpp_set_version_and_alias(firestore_v1_protos)
target_link_libraries(googleapis_cpp_firestore_v1_protos
                      PUBLIC googleapis-c++::api_annotations_protos
                             googleapis-c++::api_client_protos
                             googleapis-c++::api_field_behavior_protos
			     googleapis-c++::rpc_status_protos
                             googleapis-c++::type_latlng_protos
		      PRIVATE googleapis_cpp_common_flags )


google_cloud_cpp_grpcpp_library(
    googleapis_cpp_devtools_clouderrorreporting_v1beta1_protos
    "${GOOGLEAPIS_CPP_SOURCE}/google/devtools/clouderrorreporting/v1beta1/common.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/devtools/clouderrorreporting/v1beta1/error_group_service.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/devtools/clouderrorreporting/v1beta1/report_errors_service.proto"
    PROTO_PATH_DIRECTORIES
    "${GOOGLEAPIS_CPP_SOURCE}"
    "${PROTO_INCLUDE_DIR}")  
googleapis_cpp_set_version_and_alias(devtools_clouderrorreporting_v1beta1_protos)
target_link_libraries(googleapis_cpp_devtools_clouderrorreporting_v1beta1_protos
                      PUBLIC googleapis-c++::api_annotations_protos
                             googleapis-c++::api_client_protos
                             googleapis-c++::api_field_behavior_protos
                             googleapis-c++::api_monitored_resource_protos
                             googleapis-c++::api_resource_protos
		      PRIVATE googleapis_cpp_common_flags )


google_cloud_cpp_grpcpp_library(
    googleapis_cpp_logging_type_protos
    "${GOOGLEAPIS_CPP_SOURCE}/google/logging/type/http_request.proto" 
    "${GOOGLEAPIS_CPP_SOURCE}/google/logging/type/log_severity.proto" 
    PROTO_PATH_DIRECTORIES
    "${GOOGLEAPIS_CPP_SOURCE}"
    "${PROTO_INCLUDE_DIR}")  
googleapis_cpp_set_version_and_alias(logging_type_protos)
target_link_libraries(googleapis_cpp_logging_type_protos
                      PUBLIC googleapis-c++::api_annotations_protos
		      PRIVATE googleapis_cpp_common_flags )


google_cloud_cpp_grpcpp_library(
    googleapis_cpp_logging_v2_protos
    "${GOOGLEAPIS_CPP_SOURCE}/google/logging/v2/log_entry.proto" 
    "${GOOGLEAPIS_CPP_SOURCE}/google/logging/v2/logging.proto"
    "${GOOGLEAPIS_CPP_SOURCE}/google/logging/v2/logging_config.proto" 
    "${GOOGLEAPIS_CPP_SOURCE}/google/logging/v2/logging_metrics.proto"
    PROTO_PATH_DIRECTORIES
    "${GOOGLEAPIS_CPP_SOURCE}"
    "${PROTO_INCLUDE_DIR}")  
googleapis_cpp_set_version_and_alias(logging_v2_protos)
target_link_libraries(googleapis_cpp_logging_v2_protos
                      PUBLIC googleapis-c++::api_annotations_protos
		             googleapis-c++::api_client_protos
		             googleapis-c++::api_distribution_protos
		             googleapis-c++::api_field_behavior_protos
                             googleapis-c++::api_metric_protos
                             googleapis-c++::api_monitored_resource_protos
                             googleapis-c++::api_resource_protos
                             googleapis-c++::logging_type_protos
                             googleapis-c++::longrunning_operations_protos
                             googleapis-c++::rpc_status_protos
		      PRIVATE googleapis_cpp_common_flags )

google_cloud_cpp_grpcpp_library( 
  googleapis_cpp_monitoring_v3_protos
  "${GOOGLEAPIS_CPP_SOURCE}/google/monitoring/v3/alert.proto"
  "${GOOGLEAPIS_CPP_SOURCE}/google/monitoring/v3/alert_service.proto"
  "${GOOGLEAPIS_CPP_SOURCE}/google/monitoring/v3/common.proto"
  "${GOOGLEAPIS_CPP_SOURCE}/google/monitoring/v3/dropped_labels.proto"
  "${GOOGLEAPIS_CPP_SOURCE}/google/monitoring/v3/group.proto"
  "${GOOGLEAPIS_CPP_SOURCE}/google/monitoring/v3/group_service.proto"
  "${GOOGLEAPIS_CPP_SOURCE}/google/monitoring/v3/metric.proto"
  "${GOOGLEAPIS_CPP_SOURCE}/google/monitoring/v3/metric_service.proto"
  "${GOOGLEAPIS_CPP_SOURCE}/google/monitoring/v3/mutation_record.proto"
  "${GOOGLEAPIS_CPP_SOURCE}/google/monitoring/v3/notification.proto"
  "${GOOGLEAPIS_CPP_SOURCE}/google/monitoring/v3/notification_service.proto"
  "${GOOGLEAPIS_CPP_SOURCE}/google/monitoring/v3/span_context.proto"
  "${GOOGLEAPIS_CPP_SOURCE}/google/monitoring/v3/uptime.proto"
  "${GOOGLEAPIS_CPP_SOURCE}/google/monitoring/v3/uptime_service.proto"
    PROTO_PATH_DIRECTORIES
    "${GOOGLEAPIS_CPP_SOURCE}"
    "${PROTO_INCLUDE_DIR}")  
googleapis_cpp_set_version_and_alias(monitoring_v3_protos)
target_link_libraries(googleapis_cpp_monitoring_v3_protos
                      PUBLIC googleapis-c++::api_annotations_protos
                             googleapis-c++::api_client_protos
                             googleapis-c++::api_distribution_protos
			     googleapis-c++::api_field_behavior_protos
                             googleapis-c++::api_label_protos
                             googleapis-c++::api_launch_stage_protos
                             googleapis-c++::api_metric_protos
			     googleapis-c++::api_monitored_resource_protos
                             googleapis-c++::api_resource_protos
                             googleapis-c++::rpc_status_protos
		      PRIVATE googleapis_cpp_common_flags )

google_cloud_cpp_grpcpp_library( 
  googleapis_cpp_monitoring_dashboard_v1_protos
   "${GOOGLEAPIS_CPP_SOURCE}/google/monitoring/dashboard/v1/common.proto"
   "${GOOGLEAPIS_CPP_SOURCE}/google/monitoring/dashboard/v1/dashboard.proto"
   "${GOOGLEAPIS_CPP_SOURCE}/google/monitoring/dashboard/v1/dashboards_service.proto"
   "${GOOGLEAPIS_CPP_SOURCE}/google/monitoring/dashboard/v1/drilldowns.proto"
   "${GOOGLEAPIS_CPP_SOURCE}/google/monitoring/dashboard/v1/layouts.proto"
   "${GOOGLEAPIS_CPP_SOURCE}/google/monitoring/dashboard/v1/metrics.proto"
   "${GOOGLEAPIS_CPP_SOURCE}/google/monitoring/dashboard/v1/scorecard.proto"
   "${GOOGLEAPIS_CPP_SOURCE}/google/monitoring/dashboard/v1/service.proto"
   "${GOOGLEAPIS_CPP_SOURCE}/google/monitoring/dashboard/v1/text.proto"
   "${GOOGLEAPIS_CPP_SOURCE}/google/monitoring/dashboard/v1/widget.proto"
   "${GOOGLEAPIS_CPP_SOURCE}/google/monitoring/dashboard/v1/xychart.proto"
   PROTO_PATH_DIRECTORIES
    "${GOOGLEAPIS_CPP_SOURCE}"
    "${PROTO_INCLUDE_DIR}") 
 
googleapis_cpp_set_version_and_alias(monitoring_dashboard_v1_protos)
target_link_libraries(googleapis_cpp_monitoring_dashboard_v1_protos
                      PUBLIC googleapis-c++::api_annotations_protos
                             googleapis-c++::api_client_protos
                             googleapis-c++::api_distribution_protos
			     googleapis-c++::api_field_behavior_protos
                             googleapis-c++::api_resource_protos
		      PRIVATE googleapis_cpp_common_flags )

googleapis_cpp_add_library("google/type/calendar_period.proto")
googleapis_cpp_add_library("google/type/color.proto")
googleapis_cpp_add_library("google/type/date.proto")
googleapis_cpp_add_library("google/type/datetime.proto")
googleapis_cpp_add_library("google/type/dayofweek.proto")
googleapis_cpp_add_library("google/type/expr.proto")
googleapis_cpp_add_library("google/type/fraction.proto")
googleapis_cpp_add_library("google/type/latlng.proto")
googleapis_cpp_add_library("google/type/money.proto")
googleapis_cpp_add_library("google/type/month.proto")
googleapis_cpp_add_library("google/type/postal_address.proto")
googleapis_cpp_add_library("google/type/quaternion.proto")
googleapis_cpp_add_library("google/type/timeofday.proto")

google_cloud_cpp_grpcpp_library( 
  googleapis_cpp_type_protos
   "${GOOGLEAPIS_CPP_SOURCE}/google/type/calendar_period.proto"
   "${GOOGLEAPIS_CPP_SOURCE}/google/type/color.proto"
   "${GOOGLEAPIS_CPP_SOURCE}/google/type/date.proto"
   "${GOOGLEAPIS_CPP_SOURCE}/google/type/datetime.proto"
   "${GOOGLEAPIS_CPP_SOURCE}/google/type/dayofweek.proto"
   "${GOOGLEAPIS_CPP_SOURCE}/google/type/expr.proto"
   "${GOOGLEAPIS_CPP_SOURCE}/google/type/fraction.proto"
   "${GOOGLEAPIS_CPP_SOURCE}/google/type/latlng.proto"
   "${GOOGLEAPIS_CPP_SOURCE}/google/type/money.proto"
   "${GOOGLEAPIS_CPP_SOURCE}/google/type/month.proto"
   "${GOOGLEAPIS_CPP_SOURCE}/google/type/postal_address.proto"
   "${GOOGLEAPIS_CPP_SOURCE}/google/type/quaternion.proto"
   "${GOOGLEAPIS_CPP_SOURCE}/google/type/timeofday.proto"
   PROTO_PATH_DIRECTORIES
    "${GOOGLEAPIS_CPP_SOURCE}"
    "${PROTO_INCLUDE_DIR}") 
 
googleapis_cpp_set_version_and_alias(type_protos)
target_link_libraries(googleapis_cpp_type_protos
		      PRIVATE googleapis_cpp_common_flags )


googleapis_cpp_add_library("google/watcher/v1/watch.proto" api_annotations_protos)

# Install the libraries and headers in the locations determined by
# GNUInstallDirs
include(GNUInstallDirs)

# FIXME : visibiltiy.
# FIXME : assemble exactly the same public libraries as the Bazel builds

set(googleapis_cpp_installed_libraries_list
    googleapis_cpp_actions_type_date_range_protos
    googleapis_cpp_actions_type_datetime_range_protos
    
    # some of these should not be public shared libraries 
    googleapis_cpp_api_annotations_protos
    googleapis_cpp_api_auth_protos
    googleapis_cpp_api_backend_protos
    googleapis_cpp_api_billing_protos
    googleapis_cpp_api_client_protos
    googleapis_cpp_api_config_change_protos
    googleapis_cpp_api_consumer_protos
    googleapis_cpp_api_context_protos
    googleapis_cpp_api_control_protos
    googleapis_cpp_api_distribution_protos
    googleapis_cpp_api_documentation_protos
    googleapis_cpp_api_endpoint_protos
    googleapis_cpp_api_field_behavior_protos
    googleapis_cpp_api_http_protos
    googleapis_cpp_api_httpbody_protos
    googleapis_cpp_api_label_protos
    googleapis_cpp_api_launch_stage_protos
    googleapis_cpp_api_log_protos
    googleapis_cpp_api_logging_protos
    googleapis_cpp_api_metric_protos
    googleapis_cpp_api_monitored_resource_protos
    googleapis_cpp_api_monitoring_protos
    googleapis_cpp_api_quota_protos
    googleapis_cpp_api_resource_protos
    googleapis_cpp_api_source_info_protos
    googleapis_cpp_api_system_parameter_protos
    googleapis_cpp_api_usage_protos
    googleapis_cpp_api_service_protos
    googleapis_cpp_api_expr_v1beta1_protos
    googleapis_cpp_api_servicecontrol_v1_protos
    googleapis_cpp_api_servicemanagement_v1_protos

    googleapis_cpp_bigtable_protos
    googleapis_cpp_cloud_audit_audit_log_protos
    googleapis_cpp_cloud_automl_v1_protos
    googleapis_cpp_cloud_datalabeling_v1beta1_protos
    googleapis_cpp_cloud_kms_v1_protos
    googleapis_cpp_cloud_language_v1_protos
    googleapis_cpp_cloud_location_protos
    googleapis_cpp_cloud_ml_v1_protos
    googleapis_cpp_cloud_oslogin_v1_protos
    googleapis_cpp_cloud_redis_v1_protos
    googleapis_cpp_cloud_runtimeconfig_v1beta1_protos
    googleapis_cpp_cloud_scheduler_v1_protos
    googleapis_cpp_cloud_speech_v1_protos
    googleapis_cpp_cloud_tasks_v2_protos
    googleapis_cpp_cloud_texttospeech_v1_protos
    googleapis_cpp_cloud_translate_v3_protos
    googleapis_cpp_cloud_videointelligence_v1_protos
    googleapis_cpp_cloud_vision_v1_protos

    googleapis_cpp_datastore_v1_protos
    googleapis_cpp_datastore_admin_v1_protos


    googleapis_cpp_devtools_clouderrorreporting_v1beta1_protos
    googleapis_cpp_devtools_cloudtrace_v2_trace_protos
    googleapis_cpp_devtools_cloudtrace_v2_tracing_protos


    googleapis_cpp_firestore_v1_protos
    googleapis_cpp_firestore_admin_v1_protos

    googleapis_cpp_iam_v1_options_protos
    googleapis_cpp_iam_v1_policy_protos
    googleapis_cpp_iam_v1_iam_policy_protos

    googleapis_cpp_logging_type_protos
    googleapis_cpp_logging_v2_protos

    googleapis_cpp_longrunning_operations_protos

    googleapis_cpp_monitoring_v3_protos
    googleapis_cpp_monitoring_dashboard_v1_protos

    googleapis_cpp_rpc_code_protos
    googleapis_cpp_rpc_error_details_protos
    googleapis_cpp_rpc_context_attribute_context_protos
    googleapis_cpp_rpc_status_protos

    googleapis_cpp_type_protos
    googleapis_cpp_type_calendar_period_protos
    googleapis_cpp_type_color_protos
    googleapis_cpp_type_date_protos
    googleapis_cpp_type_datetime_protos
    googleapis_cpp_type_dayofweek_protos
    googleapis_cpp_type_expr_protos
    googleapis_cpp_type_fraction_protos
    googleapis_cpp_type_latlng_protos
    googleapis_cpp_type_money_protos
    googleapis_cpp_type_month_protos
    googleapis_cpp_type_postal_address_protos
    googleapis_cpp_type_quaternion_protos
    googleapis_cpp_type_timeofday_protos
    
    googleapis_cpp_watcher_v1_watch_protos
    
    # the ones wrapped in google-cloud-cpp 
    # still exported as gRPC libraries, without all the niceities

    googleapis_cpp_cloud_bigquery_protos
    googleapis_cpp_pubsub_protos
    googleapis_cpp_spanner_protos
    googleapis_cpp_storage_protos
    googleapis_cpp_storagetransfer_v1_protos

)

install(
    TARGETS ${googleapis_cpp_installed_libraries_list}
            googleapis_cpp_common_flags
    EXPORT googleapis-targets
    RUNTIME DESTINATION bin
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})

foreach (target ${googleapis_cpp_installed_libraries_list})
    google_cloud_cpp_install_proto_library_headers("${target}")
    google_cloud_cpp_install_proto_library_protos("${target}"
                                                  "${GOOGLEAPIS_CPP_SOURCE}")
endforeach ()

# Export the CMake targets to make it easy to create configuration files.
install(EXPORT googleapis-targets
        DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/googleapis")

# Use a function to create a scope for the variables.
function (googleapis_cpp_install_pc target)
    string(REPLACE "googleapis_cpp_" "" _short_name ${target})
    string(REPLACE "_protos" "" _short_name ${_short_name})
    set(GOOGLE_CLOUD_CPP_PC_NAME
        "The Google APIS C++ ${_short_name} Proto Library")
    set(GOOGLE_CLOUD_CPP_PC_DESCRIPTION "Compiled proto for C++.")
    # Examine the target LINK_LIBRARIES property, use that to pull the
    # dependencies between the googleapis-c++::* libraries.
    set(_target_pc_requires)
    get_target_property(_target_deps ${target} LINK_LIBRARIES)
    foreach (dep ${_target_deps})
        if ("${dep}" MATCHES "^googleapis-c\\+\\+::")
            string(REPLACE "googleapis-c++::" "googleapis_cpp_" dep "${dep}")
            list(APPEND _target_pc_requires " " "${dep}")
        endif ()
    endforeach ()
    # These dependencies are required for all the googleapis-c++::* libraries.
    list(
        APPEND
        _target_pc_requires
        " grpc++"
        " grpc"
        " openssl"
        " protobuf"
        " zlib"
        " libcares")
    string(CONCAT GOOGLE_CLOUD_CPP_PC_REQUIRES ${_target_pc_requires})
    set(GOOGLE_CLOUD_CPP_PC_LIBS "-l${target}")
    configure_file("${CMAKE_CURRENT_LIST_DIR}/config.pc.in" "${target}.pc"
                   @ONLY)
    install(FILES "${CMAKE_CURRENT_BINARY_DIR}/${target}.pc"
            DESTINATION "${CMAKE_INSTALL_LIBDIR}/pkgconfig")
endfunction ()

# Create and install the pkg-config files.
foreach (target ${googleapis_cpp_installed_libraries_list})
    googleapis_cpp_install_pc("${target}")
endforeach ()

# Create and install the googleapis pkg-config file for backwards compatibility.
set(GOOGLE_CLOUD_CPP_PC_NAME "The Google APIS C++ Proto Library")
set(GOOGLE_CLOUD_CPP_PC_DESCRIPTION
    "Provides C++ APIs to access Google Cloud Platforms.")
# Note the use of spaces, `string(JOIN)` is not available in cmake-3.5, so we
# need to add the separator ourselves.

string(
    CONCAT GOOGLE_CLOUD_CPP_PC_REQUIRES
           " googleapis_cpp_api_auth_protos"
           " googleapis_cpp_api_annotations_protos"
           " googleapis_cpp_api_client_protos"
	   " googleapis_cpp_api_distribution_protos"
           " googleapis_cpp_api_field_behavior_protos"
           " googleapis_cpp_api_http_protos"
           " googleapis_cpp_api_httpbody_protos"
           " googleapis_cpp_api_label_protos"
           " googleapis_cpp_api_launch_stage_protos"
           " googleapis_cpp_api_metric_protos"
           " googleapis_cpp_api_monitored_resource_protos"
           " googleapis_cpp_api_resource_protos"

           " googleapis_cpp_bigtable_protos"

	   " googleapis_cpp_cloud_audit_protos"
	   " googleapis_cpp_cloud_automl_v1_protos"
           " googleapis_cpp_cloud_bigquery_protos"

           " googleapis_cpp_iam_v1_iam_policy_protos"
           " googleapis_cpp_iam_v1_options_protos"
           " googleapis_cpp_iam_v1_policy_protos"

	   " googleapis_cpp_logging_v2_protos"
           " googleapis_cpp_longrunning_operations_protos"
	   " googleapis_cpp_monitoring_v3_protos"
           " googleapis_pubsub_protos"

           " googleapis_cpp_storage_protos"

           " googleapis_cpp_rpc_status_protos"
           " googleapis_cpp_rpc_error_details_protos"

           " grpc++"
           " grpc"
           " openssl"
           " protobuf"
           " zlib"
           " libcares")

foreach( lib ${googleapis_cpp_installed_libraries_list} )
  set (  GOOGLE_CLOUD_CPP_PC_REQUIRES "${GOOGLE_CLOUD_CPP_PC_REQUIRES} ${lib}" )
endforeach()

set(GOOGLE_CLOUD_CPP_PC_LIBS "")
configure_file("${CMAKE_CURRENT_LIST_DIR}/config.pc.in" "googleapis.pc" @ONLY)
install(FILES "${CMAKE_CURRENT_BINARY_DIR}/googleapis.pc"
        DESTINATION "${CMAKE_INSTALL_LIBDIR}/pkgconfig")

# Create and install the CMake configuration files.
configure_file("${CMAKE_CURRENT_LIST_DIR}/config.cmake.in"
               "googleapis-config.cmake" @ONLY)
configure_file("${CMAKE_CURRENT_LIST_DIR}/config-version.cmake.in"
               "googleapis-config-version.cmake" @ONLY)
install(
    FILES "${CMAKE_CURRENT_BINARY_DIR}/googleapis-config.cmake"
          "${CMAKE_CURRENT_BINARY_DIR}/googleapis-config-version.cmake"
          "${PROJECT_SOURCE_DIR}/cmake/FindgRPC.cmake"
          "${PROJECT_SOURCE_DIR}/cmake/FindProtobufWithTargets.cmake"
          "${PROJECT_SOURCE_DIR}/cmake/CompileProtos.cmake"
    DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/googleapis")
