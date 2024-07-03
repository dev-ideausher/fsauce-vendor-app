import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/common_image_view.dart';
import 'package:fsauce_vendor_app/app/components/custom_app_bar.dart';
import 'package:fsauce_vendor_app/app/components/empty_widget.dart';
import 'package:fsauce_vendor_app/app/constants/image_constant.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/modules/jobEditOrAdd/controllers/job_edit_or_add_controller.dart';
import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';
import 'package:get/get.dart';
import '../controllers/jobs_controller.dart';

class JobsView extends GetView<JobsController> {
  const JobsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: StringConstant.jobs,
      ),
      floatingActionButton: Container(
        height: 41.kh,
        width: 41.kw,
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: context.primary01),
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(
            Icons.add,
            color: Colors.white,
            size: 30.kw,
          ),
          onPressed: (){
            controller.toEdit.value = false;
            Get.toNamed(Routes.JOB_EDIT_OR_ADD, arguments: [false]);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10.kh, left: 16.kw, right: 16.kw),
        child: Obx(() {
          if (controller.jobs.isEmpty &&
              controller.isLoading.value &&
              controller.currentPage != 1) {
            return Center(
                child: CircularProgressIndicator(
              color: context.primary01,
            ));
          } else if(controller.jobs.isEmpty && !controller.isLoading.value){
            return EmptyWidget(title: StringConstant.noJobsFound, subTitle: StringConstant.createJobListings);
          }
          else {
            return NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (!controller.isLoading.value &&
                    scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                  controller.fetchJobs();
                }
                return false;
              },
              child: ListView.builder(
                itemCount: controller.jobs.length + 1,
                itemBuilder: (context, index) {
                  if (index == controller.jobs.length) {
                    return controller.isMoreDataAvailable.value
                        ? Center(
                            child: controller.currentPage != 1
                                ? CircularProgressIndicator(
                                    color: context.primary01,
                                  )
                                : null)
                        : Container();
                  } else {
                    final job = controller.jobs[index];
                    return Container(
                      height: 132.kh,
                      width: 100.w,
                      padding: EdgeInsets.symmetric(
                        vertical: 16.kh,
                        horizontal: 14.kw,
                      ),
                      margin: EdgeInsets.only(bottom: 16.kh),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.kw),
                        border: Border(
                          bottom: BorderSide(
                            color: context.black07,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                job.title ?? "",
                                style: TextStyleUtil.manrope16w600(),
                              ),
                              PopupMenuButton<int>(
                                color: Colors.white,
                                onSelected: (item) => {},
                                itemBuilder: (context) => [
                                  PopupMenuItem<int>(
                                      onTap: () {
                                        controller.toEdit.value = true;
                                        Get.find<JobEditOrAddController>()
                                            .gotoEditJobPage(job);
                                        Get.toNamed(Routes.JOB_EDIT_OR_ADD, arguments: [true]);
                                      },
                                      value: 1,
                                      child: Text(
                                        StringConstant.editJob,
                                        style: TextStyleUtil.manrope14w400(),
                                      )),
                                  PopupMenuItem<int>(
                                      onTap: () {
                                        controller.deleteJob(id: job.id);
                                      },
                                      value: 1,
                                      child: Text(
                                        StringConstant.deleteJob,
                                        style: TextStyleUtil.manrope14w400(
                                          color: context.primary01,
                                        ),
                                      )),
                                ],
                              )
                            ],
                          ),
                          Row(
                            children: [
                              CommonImageView(
                                svgPath: ImageConstant.jobTicket,
                              ),
                              8.kwidthBox,
                              Text(
                                "£${job.minSalary}–${job.maxSalary} ${StringConstant.perYear}",
                                style: TextStyleUtil.manrope16w400(),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  controller.showJobsBottomSheet(job);
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      StringConstant.viewDetails,
                                      style: TextStyleUtil.manrope14w400(),
                                    ),
                                    const Icon(
                                        Icons.keyboard_arrow_down_outlined),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            );
          }
        }),
      ),
    );
  }
}
