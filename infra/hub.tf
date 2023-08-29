/**
 * Copyright 2023 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

resource "google_service_directory_namespace" "apphub" {
  depends_on = [
    google_project_service.apis["servicedirectory"]
  ]

  provider     = google-beta
  project      = var.project
  namespace_id = "$$APPLICATION_NAME$$"
  location     = "us-central1" # TODO: make a variable
}

resource "google_service_directory_service" "name" {
  provider   = google-beta
  service_id = "$$APPLICATION_NAME$$"
  namespace  = google_service_directory_namespace.apphub.id

  metadata = {
    criticality = "HIGH"        # TODO: make a variable
    location    = "us-central1" # TODO: make a variable
    uri         = google_cloud_run_v2_service.backend.uri
  }
}